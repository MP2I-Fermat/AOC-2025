import 'dart:convert';
import 'dart:js_interop';

import 'package:common/protocol.dart';
import 'package:frontend/app.dart';
import 'package:frontend/providers/connection.dart';
import 'package:frontend/providers/current_code.dart';
import 'package:frontend/providers/output_provider.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_riverpod/jaspr_riverpod.dart';
import 'package:web/web.dart';

class OutputView extends StatelessComponent {
  const OutputView({super.key});

  @override
  Component build(BuildContext context) {
    return div(
      styles: Styles(
        width: .percent(100),
        height: .percent(100),
        flexDirection: .column,
      ),
      [
        div(
          styles: Styles(
            width: .percent(100),
            height: .pixels(20),
            justifyContent: .end,
          ),
          [VerticalBar(), RunButton()],
        ),
        HorizontalBar(),
        div(styles: Styles(position: .relative(), flex: Flex(grow: 1)), [
          div(
            styles: Styles(
              position: .absolute(
                top: .zero,
                bottom: .zero,
                left: .zero,
                right: .zero,
              ),
            ),
            [OutputLines()],
          ),
        ]),
        HorizontalBar(),
        div(styles: Styles(width: .percent(100), height: .pixels(20)), [
          Input(),
        ]),
      ],
    );
  }
}

class RunButton extends StatefulComponent {
  const RunButton({super.key});

  @override
  State createState() => RunButtonState();
}

enum RunState { startPending, stopPending }

class RunButtonState extends State<RunButton> {
  RunState? state;

  @override
  Component build(BuildContext context) {
    final connection = context.watch(connectionProvider).unwrapPrevious().value;
    final isRunning = context.watch(isRunningProvider);

    return div(
      styles: Styles(
        width: .pixels(100),
        cursor: connection == null || state != null ? .notAllowed : .pointer,
        userSelect: .none,
        justifyContent: .center,
      ),
      events: {
        'click': (e) {
          if (connection == null || state != null) return;

          if (!isRunning) {
            connection.send(
              jsonEncode(
                Message.startEvaluation(
                  code: context.read(codeProvider),
                ).toJson(),
              ).toJS,
            );
          } else {
            connection.send(jsonEncode(Message.stopEvaluation().toJson()).toJS);
          }
        },
      },
      [text(isRunning ? 'Arrêter' : 'Exécuter')],
    );
  }
}

class OutputLines extends StatefulComponent {
  const OutputLines({super.key});

  @override
  State<OutputLines> createState() => _OutputLinesState();
}

class _OutputLinesState extends State<OutputLines> {
  @override
  Component build(BuildContext context) {
    final lines = context.watch(outputProvider);

    return div(
      styles: Styles(
        width: .percent(100),
        height: .percent(100),
        overflow: .only(y: Overflow.auto),
      ),
      [
        div(
          styles: Styles(
            width: .percent(100),
            padding: .all(.pixels(8)),
            boxSizing: .borderBox,
            flexDirection: .column,
          ),
          [
            for (final line in lines)
              div(
                styles: Styles(
                  width: .percent(100),
                  justifyContent: line.stream == OutputStream.stdin
                      ? .end
                      : .start,
                  color: line.stream == OutputStream.stderr
                      ? Color('red')
                      : Color('white'),
                  raw: {'overflow-wrap': 'anywhere'},
                ),
                [text(line.line)],
              ),
          ],
        ),
      ],
    );
  }
}

class Input extends StatelessComponent {
  const Input({super.key});

  @override
  Component build(BuildContext context) {
    return input(
      id: 'stdin-input',
      type: .text,
      attributes: {
        'placeholder': 'Envoyez du texte au programme...',
        'autocomplete': 'off',
      },
      disabled: !context.watch(isRunningProvider),
      styles: Styles(
        width: .percent(100),
        padding: .symmetric(vertical: .zero, horizontal: .pixels(8)),
        margin: .unset,
        border: .unset,
        outline: .unset,
        appearance: .none,
        cursor: context.watch(isRunningProvider) ? null : .notAllowed,
        color: Color('white'),
        backgroundColor: .unset,
        raw: {'font-family': 'monospace'},
      ),
      events: {
        'keydown': (e) {
          if ((e as KeyboardEvent).key == "Enter") {
            final input =
                document.querySelector('#stdin-input') as HTMLInputElement;

            context
                .read(connectionProvider)
                .value!
                .send(jsonEncode(Message.inputLine(line: input.value)).toJS);
            input.value = '';
          }
        },
      },
    );
  }
}
