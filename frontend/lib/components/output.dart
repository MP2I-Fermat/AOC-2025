import 'dart:convert';
import 'dart:js_interop';

import 'package:common/protocol.dart';
import 'package:frontend/providers/connection.dart';
import 'package:frontend/providers/current_code.dart';
import 'package:frontend/providers/output_provider.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_riverpod/jaspr_riverpod.dart';

class OutputView extends StatelessComponent {
  const OutputView({super.key});

  @override
  Component build(BuildContext context) {
    final connectionState = context.watch(connectionProvider);
    final output = context.watch(outputProvider);

    return div(
      styles: Styles(
        width: .percent(100),
        height: .percent(100),
        flexDirection: .column,
        justifyContent: .center,
        alignItems: .center,
      ),

      [
        if (connectionState case AsyncData(:final value))
          button(
            onClick: () {
              value.send(
                jsonEncode(
                  StartEvaluation(code: context.read(codeProvider)),
                ).toJS,
              );
            },
            [text('start evaluation')],
          ),

        div(styles: Styles(flexDirection: .column), [
          for (final line in output) div([text(line.line)]),
        ]),
      ],
    );
  }
}
