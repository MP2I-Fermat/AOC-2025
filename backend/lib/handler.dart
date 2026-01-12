import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:backend/evaluation.dart';
import 'package:backend/problems.dart';
import 'package:collection/collection.dart';
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

  void sendUsersUpdate(ConnectionState state) {
    final users = {
      for (final MapEntry(:key, :value) in connections.entries)
        if (value.clientState case EditingState(
          :final nick?,
          :final problemsStatus,
        ))
          key: UserInfo(
            nick: nick,
            numViewers: connections.values.where((st) {
              if (st.clientState case WatchingState(:final target)) {
                return target == key;
              }
              return false;
            }).length,
            problemNumber: problemsStatus.values
                .where((info) => info.unlocked)
                .length,
            displayStatus:
                problemsStatus.entries
                    .sorted((a, b) => a.key.compareTo(b.key))
                    .map((e) => e.value)
                    .takeWhile((e) => e.unlocked)
                    .lastOrNull
                    ?.testCaseStatus
                    .fold(TestStatus.pending, (acc, status) {
                      // pending -> success -> running -> failed
                      if (status == TestStatus.failed) {
                        return TestStatus.failed;
                      } else if (status == TestStatus.running &&
                          acc != TestStatus.failed) {
                        return TestStatus.running;
                      } else if (status == TestStatus.success &&
                          acc != TestStatus.running &&
                          acc != TestStatus.failed) {
                        return TestStatus.success;
                      }

                      return acc;
                    }) ??
                TestStatus.pending,
          ),
    };
    state.send(UsersUpdate(users: users, yourId: state.id));
  }

  void broadcastUsersUpdate() => connections.values.forEach(sendUsersUpdate);

  Future<void> handle(WebSocketChannel channel) async {
    final state = ConnectionState(
      channel: channel,
      id: nextId(),
      handler: this,
    );
    connections[state.id] = state;

    sendUsersUpdate(state);

    EditingState requireEditing() {
      if (state.clientState case EditingState state) {
        return state;
      }

      throw Exception('Client is not editing');
    }

    requireEditing().problemsStatus = {
      for (final (i, MapEntry(:key, :value))
          in (await Problem.problems).entries
              .sorted((a, b) => a.key.compareTo(b.key))
              .indexed)
        key: ProblemInfo(
          unlocked: i == 0,
          testCaseStatus: List.filled(
            value.testCases.length,
            TestStatus.pending,
          ),
        ),
    };
    state.send(ProblemsUpdate(problems: requireEditing().problemsStatus));

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
            final evaluation = requireEditing().activeEvaluation;
            if (evaluation == null || !evaluation.allowExternalInput) {
              return;
            }
            evaluation.input(line);
          case OutputUpdate():
            throw Exception('Clients cannot send OutputUpdate');
          case StartWritingCode(:final nick):
            if (nick != null && (nick.isEmpty || nick.length >= 200)) {
              throw Exception('Invalid nickname');
            }

            if (state.clientState case EditingState previousState) {
              previousState.nick = nick;
            } else {
              final editingState = EditingState(
                handler: this,
                connectionState: state,
                nick: nick,
              );

              editingState.problemsStatus = {
                for (final (i, MapEntry(:key, :value))
                    in (await Problem.problems).entries
                        .sorted((a, b) => a.key.compareTo(b.key))
                        .indexed)
                  key: ProblemInfo(
                    unlocked: i == 0,
                    testCaseStatus: List.filled(
                      value.testCases.length,
                      TestStatus.pending,
                    ),
                  ),
              };

              state.clientState = editingState;

              state.send(
                OutputUpdate(
                  output: [],
                  isRunning: false,
                  isInputEnabled:
                      editingState.activeEvaluation?.allowExternalInput == true,
                ),
              );
              state.send(ProblemsUpdate(problems: editingState.problemsStatus));
            }

            broadcastUsersUpdate();
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
                  isInputEnabled:
                      targetState.activeEvaluation?.allowExternalInput == true,
                ),
              )
              ..send(ProblemsUpdate(problems: targetState.problemsStatus));

            broadcastUsersUpdate();

            for (final connection in connections.values) {
              if (connection.clientState case WatchingState st) {
                if (st.target == state.id) {
                  connection.clientState = WaitingState();
                }
              }
            }
          case SubmitSolution(problem: final problemName, :final code):
            final problem = (await Problem.problems)[problemName];
            if (problem == null) {
              throw Exception('Unknown problem');
            }

            await requireEditing().activeEvaluation?.cancel();

            final sortedProblemNames = (await Problem.problems).keys.sorted();

            // Force unlock problem and all previous problems so they are
            // displayed correctly in the event of a connection restart.
            final currentProblemIdx = sortedProblemNames.indexOf(problemName);
            for (int i = 0; i <= currentProblemIdx; i++) {
              if (requireEditing().problemsStatus[sortedProblemNames[i]]
                  case final state?) {
                requireEditing().problemsStatus[sortedProblemNames[i]] = state
                    .copyWith(unlocked: true);
              }
            }
            final problemState = requireEditing().problemsStatus[problemName];
            if (problemState == null) {
              throw StateError(
                'Invalid internal state: missing problem status',
              );
            }

            final results = List.filled(
              problem.testCases.length,
              TestStatus.pending,
            );
            var isRunning = true;
            final output = <OutputLine>[];

            void broadcastUpdate() {
              broadcastUsersUpdate();

              final newState = problemState.copyWith(testCaseStatus: results);

              final problems = requireEditing().problemsStatus;
              problems[problemName] = newState;
              state.send(ProblemsUpdate(problems: problems));

              for (final connection in connections.values) {
                if (connection.clientState case WatchingState st) {
                  if (st.target == state.id) {
                    connection.send(ProblemsUpdate(problems: problems));
                  }
                }
              }

              state.send(
                OutputUpdate(
                  output: output,
                  isRunning: isRunning,
                  isInputEnabled: false,
                ),
              );
              for (final connection in connections.values) {
                if (connection.clientState case WatchingState st) {
                  if (st.target == state.id) {
                    connection.send(
                      OutputUpdate(
                        output: output,
                        isRunning: isRunning,
                        isInputEnabled: false,
                      ),
                    );
                  }
                }
              }
            }

            broadcastUpdate();

            Future<void> test() async {
              var skipRemaining = false;

              try {
                for (final (i, testCase) in problem.testCases.indexed) {
                  if (skipRemaining) {
                    results[i] = TestStatus.pending;
                    continue;
                  }

                  output.add(
                    OutputLine(
                      stream: OutputStream.stdout,
                      line: 'Lancement du test #${i + 1}...',
                    ),
                  );

                  final evaluation = await Evaluation.start(
                    code,
                    allowExternalInput: false,
                  );
                  evaluation.onOutputChange.drain();

                  requireEditing().activeEvaluation = evaluation;

                  results[i] = TestStatus.running;
                  broadcastUpdate();

                  const LineSplitter()
                      .convert(testCase.input.trim())
                      .forEach(evaluation.input);
                  evaluation.input('');

                  final exitCode = await evaluation.exitCode;
                  requireEditing().activeEvaluation = null;

                  String? failureReason;

                  if (exitCode != 0) {
                    failureReason = 'Le programme a terminé avec une erreur';
                  }

                  if (failureReason == null) {
                    final output = evaluation.outputLines
                        .where((l) => l.stream == OutputStream.stdout)
                        .map((l) => l.line)
                        .join('\n')
                        .trim();

                    if (output != testCase.output.trim()) {
                      failureReason = 'Résultat incorrect';
                    }
                  }

                  if (failureReason != null) {
                    results[i] = TestStatus.failed;
                    skipRemaining = true;

                    output.add(
                      OutputLine(
                        stream: OutputStream.stderr,
                        line: 'Test #${i + 1} échoué: $failureReason',
                      ),
                    );
                  } else {
                    results[i] = TestStatus.success;

                    output.add(
                      OutputLine(
                        stream: OutputStream.stdout,
                        line: 'Test #${i + 1} passé',
                      ),
                    );
                  }
                }
              } finally {
                isRunning = false;

                if (results.every((status) => status == TestStatus.success)) {
                  final display = switch (requireEditing().nick) {
                    String nick => '$nick (${state.id})',
                    null => state.id.toString(),
                  };

                  print(
                    'User $display completed problem $problemName at ${DateTime.now()}',
                  );

                  final index = sortedProblemNames.indexOf(problemName);
                  if (index == -1) throw StateError('invalid state');

                  // Unlock next problem
                  if (index != sortedProblemNames.length - 1) {
                    final nextProblemName = sortedProblemNames[index + 1];

                    if (requireEditing().problemsStatus[nextProblemName]
                        case final nextProblem?) {
                      if (!nextProblem.unlocked) {
                        requireEditing().problemsStatus[nextProblemName] =
                            nextProblem.copyWith(unlocked: true);
                      }
                    }
                  }
                }

                broadcastUpdate();
              }
            }

            // Don't block processing more messages.
            test();
          case UsersUpdate():
            throw Exception('Clients cannot send UsersUpdate');
          case ProblemsUpdate():
            throw Exception('Clients cannot send ProblemsUpdate');
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

      broadcastUsersUpdate();
    }
  }
}

class ConnectionState {
  final int id;

  final ConnectionHandler handler;
  final WebSocketChannel channel;

  late ClientState clientState = EditingState(
    connectionState: this,
    handler: handler,
  );

  ConnectionState({
    required this.channel,
    required this.handler,
    required this.id,
  });

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
  String? nick;

  Map<String, ProblemInfo> problemsStatus = {};

  EditingState({
    required this.handler,
    required this.connectionState,
    this.nick,
    this.code = '',
    List<OutputLine>? currentLines,
  }) : currentLines = currentLines ?? [];

  String code;

  Evaluation? activeEvaluation;
  List<OutputLine> currentLines;

  Future<Evaluation> startEvaluation() async {
    final evaluation = await Evaluation.start(code, allowExternalInput: true);
    activeEvaluation = evaluation;

    currentLines.clear();

    Timer? updateTimer;
    void scheduleUpdate({required bool isRunning}) {
      void sendUpdate() {
        connectionState.send(
          OutputUpdate(
            output: currentLines,
            isRunning: isRunning,
            isInputEnabled: true,
          ),
        );
        for (final connection in handler.connections.values) {
          if (connection.clientState case WatchingState st) {
            if (st.target == connectionState.id) {
              connection.send(
                OutputUpdate(
                  output: currentLines,
                  isRunning: isRunning,
                  isInputEnabled: true,
                ),
              );
            }
          }
        }
      }

      if (isRunning) {
        updateTimer ??= Timer(Duration(milliseconds: 100), () {
          sendUpdate();
          updateTimer = null;
        });
      } else {
        updateTimer?.cancel();
        updateTimer = null;

        sendUpdate();
      }
    }

    scheduleUpdate(isRunning: true);

    evaluation.onOutputChange.listen(
      (lines) {
        currentLines = lines;

        if (currentLines.length > 1000) {
          evaluation.cancel();
          return;
        }

        scheduleUpdate(isRunning: true);
      },
      onDone: () {
        scheduleUpdate(isRunning: false);

        activeEvaluation = null;
      },
    );

    return evaluation;
  }
}
