import 'dart:convert';

import 'package:common/protocol.dart';
import 'package:frontend/components/huitr_markdown.dart';
import 'package:frontend/providers/connection.dart';
import 'package:frontend/providers/current_code.dart';
import 'package:frontend/providers/output_provider.dart';
import 'package:frontend/providers/problem_state.dart';
import 'package:frontend/providers/state.dart';
import 'package:http/http.dart' as http;
import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_riverpod/jaspr_riverpod.dart';

class Problems extends StatefulComponent {
  const Problems({super.key});

  @override
  State createState() => ProblemsState();
}

class ProblemsState extends State<Problems> {
  final Future<Map<String, String>> problemsFuture = http
      .get(Uri.parse('${ConnectionNotifier.apiHostOverride}/api/problems'))
      .then(
        (r) => (jsonDecode(utf8.decode(r.bodyBytes)) as Map)
            .cast<String, String>(),
      );

  @override
  Component build(BuildContext context) {
    // Start listening immediately or we will miss the problem update message.
    final problemStates = context.watch(problemStateProvider);

    return div(
      styles: Styles(
        display: .block,
        width: .percent(100),
        height: .percent(100),
        overflow: .only(y: Overflow.auto),
      ),

      [
        FutureBuilder(
          future: problemsFuture,
          builder: (context, snapshot) {
            final problems = snapshot.data;
            if (problems == null) {
              return Component.text('Chargement des problèmes...');
            }

            return div(styles: Styles(padding: .all(.pixels(8))), [
              Builder(
                builder: (context) {
                  final unlockedProblems =
                      problemStates.entries
                          .where((e) => e.value.unlocked)
                          .map((e) => e.key)
                          .toList()
                        ..sort();

                  if (unlockedProblems.isEmpty) {
                    return Component.text('Aucun problème disponible.');
                  }

                  return div(
                    styles: Styles(
                      width: .percent(100),
                      flexDirection: .column,
                    ),
                    [
                      for (final problem in unlockedProblems)
                        ProblemView(
                          name: problem,
                          prompt: problems[problem]!,
                          info: problemStates[problem]!,
                        ),
                      div(styles: Styles(height: .pixels(300)), []),
                    ],
                  );
                },
              ),
            ]);
          },
        ),
      ],
    );
  }
}

class ProblemView extends StatelessComponent {
  final String name;
  final String prompt;
  final ProblemInfo info;

  const ProblemView({
    super.key,
    required this.name,
    required this.prompt,
    required this.info,
  });

  @override
  Component build(BuildContext context) {
    final isRunning = context.watch(isRunningProvider);
    final isWriting = context.watch(stateProvider) is Writing;
    final connection = context.watch(connectionProvider).unwrapPrevious().value;

    return div(styles: Styles(width: .percent(100), flexDirection: .column), [
      h3([Component.text(name)]),
      HuitrMarkdown(markdown: prompt),
      div(styles: Styles(justifyContent: .spaceBetween), [
        div(
          styles: Styles(
            padding: .symmetric(vertical: .pixels(2), horizontal: .pixels(8)),
            border: .all(
              color: Color('var(--secondary-color)'),
              width: .pixels(1),
            ),
            radius: .all(.circular(.pixels(4))),
            alignItems: .center,
          ),
          [
            for (final status in info.testCaseStatus)
              div(
                styles: Styles(
                  width: .pixels(10),
                  height: .pixels(10),
                  margin: .symmetric(horizontal: .pixels(8)),
                  radius: .all(.circular(.percent(50))),
                  backgroundColor: switch (status) {
                    TestStatus.pending => .new('var(--secondary-color)'),
                    TestStatus.running => .new('yellow'),
                    TestStatus.success => .new('green'),
                    TestStatus.failed => .new('red'),
                  },
                ),
                [],
              ),
          ],
        ),
        div(
          styles: Styles(
            padding: .symmetric(vertical: .pixels(2), horizontal: .pixels(8)),
            border: .all(
              color: Color('var(--secondary-color)'),
              width: .pixels(1),
            ),
            radius: .all(.circular(.pixels(4))),
            cursor: isRunning || !isWriting || connection == null
                ? .notAllowed
                : .pointer,
            userSelect: .none,
          ),
          events: {
            'click': (e) {
              if (isRunning || !isWriting || connection == null) return;

              connection.send(
                SubmitSolution(problem: name, code: context.read(codeProvider)),
              );
            },
          },
          [Component.text('Tester')],
        ),
      ]),
    ]);
  }
}
