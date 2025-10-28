import 'dart:convert';

import 'package:backend/evaluation.dart';
import 'package:common/protocol.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ConnectionHandler {
  final Set<ConnectionState> connections = {};

  Future<void> handle(WebSocketChannel channel) async {
    final state = ConnectionState(channel);
    connections.add(state);

    EditingState requireEditing() {
      if (state.clientState case EditingState state) {
        return state;
      }

      return state.clientState = EditingState(state);
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
          case StartEvaluation(:final code):
            final editingState = requireEditing();
            await editingState.activeEvaluation?.cancel();
            editingState.code = code;
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
        }
      }
    } finally {
      connections.remove(state);
    }
  }
}

class ConnectionState {
  final WebSocketChannel channel;

  late ClientState clientState = EditingState(this);

  ConnectionState(this.channel);
}

sealed class ClientState {}

final class EditingState extends ClientState {
  final ConnectionState connectionState;

  EditingState(this.connectionState);

  String code = '';

  Evaluation? activeEvaluation;

  Future<Evaluation> startEvaluation() async {
    final evaluation = await Evaluation.start(code);
    activeEvaluation = evaluation;

    final lines = <OutputLine>[];

    connectionState.channel.sink.add(
      jsonEncode(OutputUpdate(output: lines).toJson()),
    );

    evaluation.lines.listen(
      (line) {
        lines.add(line);

        connectionState.channel.sink.add(
          jsonEncode(OutputUpdate(output: lines).toJson()),
        );
      },
      onDone: () {
        connectionState.channel.sink.add(
          jsonEncode(OutputUpdate(output: null).toJson()),
        );

        activeEvaluation = null;
      },
    );

    return evaluation;
  }
}
