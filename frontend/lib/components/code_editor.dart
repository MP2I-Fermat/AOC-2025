import 'package:frontend/components/highlighted_code.dart';
import 'package:frontend/providers/current_code.dart';
import 'package:frontend/providers/state.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_riverpod/jaspr_riverpod.dart';
import 'package:web/web.dart';

class CodeEditor extends StatefulComponent {
  const CodeEditor({super.key});

  @override
  State createState() => CodeEditorState();
}

class CodeEditorState extends State<CodeEditor> {
  var verticalScrollOffset = 0.0;
  late String initialContent;

  final Key codeInputKey = UniqueKey();
  final Key blockInputKey = UniqueKey();

  @override
  void initState() {
    super.initState();

    initialContent = context.read(codeProvider);
  }

  @override
  Component build(BuildContext context) {
    context.listen(stateProvider, (_, state) {
      if (state is Writing) {
        setState(() {
          initialContent = context.read(codeProvider);
        });
      }
    });

    final content = context.watch(codeProvider);
    final state = context.watch(stateProvider);

    var lineCount = '\n'.allMatches(content).length + 1;

    return div(
      key: codeInputKey,
      styles: Styles(
        position: .relative(),
        width: .percent(100),
        height: .percent(100),
        fontSize: .pixels(13),
        // WebKit doesn't work if we set font-family: "monospace", so set it
        // unquoted.
        raw: {'font-family': 'monospace'},
      ),
      [
        div(
          styles: Styles(
            position: .absolute(
              top: .zero,
              bottom: .zero,
              left: .zero,
              right: .zero,
            ),
            flexDirection: .row,
          ),
          [
            div(
              styles: Styles(
                padding: .symmetric(horizontal: .pixels(8)),
                overflow: .only(y: Overflow.hidden),
              ),
              [
                div(
                  styles: Styles(
                    position: .relative(top: .pixels(-verticalScrollOffset)),
                    padding: .symmetric(vertical: .pixels(8)),
                    flexDirection: .column,
                    alignItems: .end,
                  ),
                  [
                    for (int i = 1; i <= lineCount; i++) div([text("$i")]),
                  ],
                ),
              ],
            ),
            div(
              id: 'code-editor-scroll',
              styles: Styles(
                padding: .fromLTRB(.zero, .pixels(8), .pixels(8), .pixels(8)),
                overflow: .auto,
                flex: Flex(grow: 1, basis: .zero),
                whiteSpace: .pre,
                raw: {'overscroll-behavior': 'none'},
              ),
              events: {
                'scroll': (e) {
                  final editorScroll =
                      document.querySelector('#code-editor-scroll')
                          as HTMLElement;
                  setState(() => verticalScrollOffset = editorScroll.scrollTop);
                },
              },
              [
                div(
                  styles: Styles(
                    position: .relative(),
                    width: .percent(100),
                    height: .maxContent,
                    minWidth: .maxContent,
                    minHeight: .percent(100),
                  ),
                  [
                    if (state case Writing())
                      textarea(
                        id: 'code-input',
                        styles: Styles(
                          display: .inline,
                          position: .absolute(
                            top: .zero,
                            bottom: .zero,
                            left: .zero,
                            right: .zero,
                          ),
                          zIndex: ZIndex(1),
                          padding: .unset,
                          margin: .unset,
                          border: .none,
                          outline: Outline(style: .none),
                          // Opacity 0 hides the cursor, just render the text as
                          // transparent instead.
                          // color: .rgba(0, 0, 0, 0),
                          fontSize: .pixels(13),
                          whiteSpace: .pre,
                          backgroundColor: .rgba(0, 0, 0, 0),
                          raw: {
                            'caret-color': 'var(--primary-color)',
                            'resize': 'none',
                            'font-family': 'monospace',
                          },
                        ),
                        attributes: {'spellcheck': 'false'},
                        events: {
                          'keydown': (e) {
                            final editor =
                                document.querySelector('#code-input')
                                    as HTMLTextAreaElement;
                            e as KeyboardEvent;
                            final code = context.read(codeProvider);

                            if (e.key == 'Tab') {
                              e.preventDefault();

                              if (!e.shiftKey) {
                                // Plain tab
                                if (editor.selectionStart ==
                                    editor.selectionEnd) {
                                  document.execCommand(
                                    'insertText',
                                    false,
                                    '  ',
                                  );
                                } else {
                                  var lineStart = editor.selectionStart;
                                  while (lineStart > 0 &&
                                      code[lineStart - 1] != '\n') {
                                    lineStart--;
                                  }

                                  final selection = code.substring(
                                    lineStart,
                                    editor.selectionEnd,
                                  );

                                  final indented =
                                      '  ${selection.replaceAll('\n', '\n  ')}';

                                  final initialStart = editor.selectionStart;

                                  editor.selectionStart = lineStart;
                                  document.execCommand(
                                    'insertText',
                                    false,
                                    indented,
                                  );

                                  editor.selectionStart = initialStart + 2;
                                }
                              } else {
                                var lineStart = editor.selectionStart;
                                while (lineStart > 0 &&
                                    code[lineStart - 1] != '\n') {
                                  lineStart--;
                                }

                                final selection = code.substring(
                                  lineStart,
                                  editor.selectionEnd,
                                );

                                final outdentStart = selection.startsWith('  ');

                                final indented = outdentStart
                                    ? selection
                                          .replaceAll('\n  ', '\n')
                                          .substring(2)
                                    : selection.replaceAll('\n  ', '\n');

                                final initialStart = editor.selectionStart;

                                editor.selectionStart = lineStart;
                                document.execCommand(
                                  'insertText',
                                  false,
                                  indented,
                                );

                                editor.selectionStart = outdentStart
                                    ? initialStart - 2
                                    : initialStart;
                              }
                            } else if (e.key == '/' && e.ctrlKey) {
                              e.preventDefault();

                              var lineStart = editor.selectionStart;
                              while (lineStart > 0 &&
                                  code[lineStart - 1] != '\n') {
                                lineStart--;
                              }

                              final selection = code.substring(
                                lineStart,
                                editor.selectionEnd,
                              );

                              final lines = selection.split('\n');
                              final isUncomment = lines.every(
                                (line) =>
                                    line.trim().isEmpty || line.startsWith('.'),
                              );

                              final newLines = isUncomment
                                  ? lines.map((line) {
                                      if (line.startsWith('. ')) {
                                        return line.substring(2);
                                      } else if (line.startsWith('.')) {
                                        return line.substring(1);
                                      } else {
                                        return line;
                                      }
                                    })
                                  : lines.map((line) {
                                      if (line.trim().isEmpty) {
                                        return line;
                                      }

                                      return '. $line';
                                    });

                              final newSelection = newLines.join('\n');

                              final initialStart = editor.selectionStart;
                              editor.selectionStart = lineStart;

                              document.execCommand(
                                'insertText',
                                false,
                                newSelection,
                              );

                              editor.selectionStart = initialStart;
                            }
                          },
                        },
                        onInput: context
                            .read(codeProvider.notifier)
                            .setStoredCode,
                        [text(initialContent)],
                      )
                    else
                      div(
                        key: blockInputKey,
                        styles: Styles(
                          position: .absolute(
                            top: .zero,
                            bottom: .zero,
                            left: .zero,
                            right: .zero,
                          ),
                          zIndex: ZIndex(1),
                          cursor: .notAllowed,
                        ),
                        [],
                      ),
                    div(styles: Styles(zIndex: ZIndex(0), flexDirection: .column), [
                      HighlightedCode(code: context.watch(codeProvider)),
                      // Needed to force the browser to size the inner scroll area correctly.
                      // If this is absent the textarea may sometimes begin scrolling within
                      // itself.
                      div([raw('&ZeroWidthSpace;')]),
                    ]),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
