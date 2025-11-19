import 'dart:convert';
import 'dart:math';

import 'package:backend/evaluation.dart';
import 'package:common/protocol.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ConnectionHandler {
  final Map<int, ConnectionState> connections = {};

  int nextId() {
    final r = Random();
    int res;
    do {
      res = r.nextInt((connections.length + 1) * 256);
    } while (connections.containsKey(res));
    return res;
  }

  Future<void> handle(WebSocketChannel channel) async {
    final state = ConnectionState(channel: channel, id: nextId());
    connections[state.id] = state;

    final users = {
      for (final MapEntry(:key, :value) in connections.entries)
        if (value.clientState case EditingState state) key: state.nick,
    };
    state.send(UsersUpdate(users: users, yourId: state.id));

    EditingState requireEditing() {
      if (state.clientState case EditingState state) {
        return state;
      }

      throw Exception('Client is not editing');
    }

    try {
      await for (final payload in channel.stream) {
        if (payload is! String) {
          throw Exception('Message was not a string');
        }
        if (payload.length > 1000 * 1000) {
          throw Exception('Message exceeded 1MB limit');
        }
        final message = Message.fromJson(jsonDecode(payload));

        switch (message) {
          case CodeUpdate(:final code):
            requireEditing().code = code;

            for (final connection in connections.values) {
              if (connection.clientState case WatchingState st) {
                if (st.target == state.id) {
                  connection.send(CodeUpdate(code: code));
                }
              }
            }
          case StartEvaluation(:final code):
            final editingState = requireEditing();
            await editingState.activeEvaluation?.cancel();
            editingState.code = code;

            for (final connection in connections.values) {
              if (connection.clientState case WatchingState st) {
                if (st.target == state.id) {
                  connection.send(CodeUpdate(code: code));
                }
              }
            }

            await editingState.startEvaluation();
          case StopEvaluation():
            final editingState = requireEditing();
            await editingState.activeEvaluation?.cancel();
          case InputLine(:final line):
            final editingState = requireEditing();
            // Allow InputLine when no evaluation is active.
            editingState.activeEvaluation?.input(line);
          case OutputUpdate():
            throw Exception('Clients cannot send OutputUpdate');
          case StartWritingCode(:final nick):
            if (nick.isEmpty || nick.length >= 200) {
              throw Exception('Invalid nickname');
            }

            String currentCode = '';
            if (state.clientState case EditingState previousState) {
              previousState.activeEvaluation?.cancel();
              currentCode = previousState.code;
            }

            state.clientState = EditingState(
              handler: this,
              connectionState: state,
              nick: nick,
              code: currentCode,
            );

            state.send(OutputUpdate(output: [], isRunning: false));

            final users = {
              for (final MapEntry(:key, :value) in connections.entries)
                if (value.clientState case EditingState state) key: state.nick,
            };
            for (final connection in connections.values) {
              connection.send(UsersUpdate(users: users, yourId: connection.id));
            }
          case Watch(:final id):
            if (state.clientState case EditingState st) {
              await st.activeEvaluation?.cancel();
            }

            final targetState = connections[id]?.clientState;
            if (targetState is! EditingState) {
              // Target disconnected or switched to watching before we started
              // watching them.
              state.clientState = WaitingState();
              continue;
            }

            state
              ..clientState = WatchingState(target: id)
              ..send(CodeUpdate(code: targetState.code))
              ..send(
                OutputUpdate(
                  output: targetState.currentLines,
                  isRunning: targetState.activeEvaluation != null,
                ),
              );

            final users = {
              for (final MapEntry(:key, :value) in connections.entries)
                if (value.clientState case EditingState state) key: state.nick,
            };
            for (final connection in connections.values) {
              connection.send(UsersUpdate(users: users, yourId: connection.id));
            }

            for (final connection in connections.values) {
              if (connection.clientState case WatchingState st) {
                if (st.target == state.id) {
                  connection.clientState = WaitingState();
                }
              }
            }
          case UsersUpdate():
            throw Exception('Clients cannot send UsersUpdate');
        }
      }
    } finally {
      for (final connection in connections.values) {
        if (connection.clientState case WatchingState st) {
          if (st.target == state.id) {
            connection.clientState = WaitingState();
          }
        }
      }

      connections.remove(state.id);

      final users = {
        for (final MapEntry(:key, :value) in connections.entries)
          if (value.clientState case EditingState state) key: state.nick,
      };
      for (final connection in connections.values) {
        connection.send(UsersUpdate(users: users, yourId: connection.id));
      }
    }
  }
}

class ConnectionState {
  final int id;

  final WebSocketChannel channel;

  late ClientState clientState = WaitingState();

  ConnectionState({required this.channel, required this.id});

  void send(Message m) {
    channel.sink.add(jsonEncode(m.toJson()));
  }
}

sealed class ClientState {}

final class WaitingState extends ClientState {}

final class WatchingState extends ClientState {
  final int target;

  WatchingState({required this.target});
}

final class EditingState extends ClientState {
  final ConnectionHandler handler;

  final ConnectionState connectionState;
  final String nick;

  EditingState({
    required this.handler,
    required this.connectionState,
    required this.nick,
    this.code = '',
  });

  String code;

  Evaluation? activeEvaluation;
  final List<OutputLine> currentLines = [];

  Future<Evaluation> startEvaluation() async {
    final evaluation = await Evaluation.start(code);
    activeEvaluation = evaluation;

    currentLines.clear();

    connectionState.send(OutputUpdate(output: currentLines, isRunning: true));
    for (final connection in handler.connections.values) {
      if (connection.clientState case WatchingState st) {
        if (st.target == connectionState.id) {
          connection.send(OutputUpdate(output: currentLines, isRunning: true));
        }
      }
    }

    evaluation.lines.listen(
      (line) {
        if (currentLines.length > 1000) {
          evaluation.cancel();
          return;
        }

        currentLines.add(line);

        connectionState.send(
          OutputUpdate(output: currentLines, isRunning: true),
        );
        for (final connection in handler.connections.values) {
          if (connection.clientState case WatchingState st) {
            if (st.target == connectionState.id) {
              connection.send(
                OutputUpdate(output: currentLines, isRunning: true),
              );
            }
          }
        }
      },
      onDone: () {
        connectionState.send(
          OutputUpdate(output: currentLines, isRunning: false),
        );
        for (final connection in handler.connections.values) {
          if (connection.clientState case WatchingState st) {
            if (st.target == connectionState.id) {
              connection.send(
                OutputUpdate(output: currentLines, isRunning: false),
              );
            }
          }
        }

        activeEvaluation = null;
      },
    );

    return evaluation;
  }
}
