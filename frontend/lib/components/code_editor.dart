import 'dart:async';
import 'dart:math';

import 'package:frontend/components/highlighted_code.dart';
import 'package:frontend/providers/current_code.dart';
import 'package:frontend/providers/saved_code.dart';
import 'package:frontend/providers/state.dart';
import 'package:jaspr/dom.dart';
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
  var justInsertedMatchingBraces = false;
  late String initialContent;
  (int, int)? pendingCursorPosition;

  final Key editorKey = UniqueKey();
  final Key blockInputKey = UniqueKey();
  Key inputKey = UniqueKey();

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

    context.listen(currentSlotProvider, (_, slot) {
      if (slot != null) {
        setState(() {
          initialContent = slot.code;
          // Force textarea to discard old content.
          inputKey = UniqueKey();
        });
      }
    });

    if (pendingCursorPosition case (final start, final end)?) {
      scheduleMicrotask(() {
        final editor =
            document.querySelector('#code-input') as HTMLTextAreaElement;

        editor.focus();
        editor.selectionStart = start;
        editor.selectionEnd = end;

        pendingCursorPosition = null;
      });
    }

    final content = context.watch(codeProvider);
    final state = context.watch(stateProvider);

    var lineCount = '\n'.allMatches(content).length + 1;

    return div(
      key: editorKey,
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
              events: {
                'wheel': (e) {
                  // TODO: It would be smoother if the line numbers were
                  // themselves scrollable, but we run into issues ensuring that
                  // their scroll height is the same scroll height as the
                  // editor.
                  e as WheelEvent;
                  setState(() {
                    final editorScroll =
                        document.querySelector('#code-editor-scroll')
                            as HTMLElement;

                    final targetScrollOffset = verticalScrollOffset + e.deltaY;

                    verticalScrollOffset = max(
                      0,
                      min(
                        targetScrollOffset,
                        (editorScroll.scrollHeight - editorScroll.clientHeight)
                            .toDouble(),
                      ),
                    );
                    editorScroll.scrollTop = verticalScrollOffset;
                  });
                },
              },
              [
                div(
                  styles: Styles(
                    position: .relative(top: .pixels(-verticalScrollOffset)),
                    padding: .symmetric(vertical: .pixels(8)),
                    flexDirection: .column,
                    alignItems: .end,
                  ),
                  [
                    for (int i = 1; i <= lineCount; i++)
                      div([Component.text("$i")]),
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
                        key: inputKey,
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
                          color: .rgba(0, 0, 0, 0),
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
                            } else if (e.key == 'Enter') {
                              e.preventDefault();

                              if (e.ctrlKey) {
                                // This is ugly and should probably be moved to
                                // a provider but clicking the button is just
                                // sooooooooooooooooooooooo convenient.
                                (document.getElementById('run-button')
                                        as HTMLElement)
                                    .click();
                                return;
                              }

                              var lineStart = editor.selectionStart;
                              while (lineStart > 0 &&
                                  code[lineStart - 1] != '\n') {
                                lineStart--;
                              }
                              var lineEnd = code.indexOf('\n', lineStart);
                              if (lineEnd == -1) {
                                lineEnd = code.length;
                              }
                              final line = code.substring(lineStart, lineEnd);

                              var currentIndentation = 0;
                              while (currentIndentation < line.length &&
                                  line[currentIndentation] == ' ') {
                                currentIndentation++;
                              }

                              if (editor.selectionStart > 0 &&
                                  editor.selectionEnd < code.length &&
                                  code[editor.selectionStart - 1] == '[' &&
                                  code[editor.selectionEnd] == ']') {
                                document.execCommand(
                                  'insertText',
                                  false,
                                  '\n${' ' * currentIndentation}  \n${' ' * currentIndentation}',
                                );
                                editor.selectionStart -= currentIndentation + 1;
                                editor.selectionEnd = editor.selectionStart;
                              } else {
                                document.execCommand(
                                  'insertText',
                                  false,
                                  '\n${' ' * currentIndentation}',
                                );
                              }
                            } else if (e.key == '[') {
                              if (editor.selectionStart < code.length &&
                                  editor.selectionStart ==
                                      editor.selectionEnd &&
                                  code[editor.selectionStart].contains(
                                    RegExp(r'[^\[\]()\s]'),
                                  )) {
                                return;
                              }

                              final selectedCode = code.substring(
                                editor.selectionStart,
                                editor.selectionEnd,
                              );

                              e.preventDefault();
                              document.execCommand(
                                'insertText',
                                false,
                                '[$selectedCode]',
                              );
                              editor.selectionStart -= 1 + selectedCode.length;
                              editor.selectionEnd -= 1;

                              setState(() {
                                justInsertedMatchingBraces = true;
                              });
                            } else if (e.key == '(') {
                              if (editor.selectionStart < code.length &&
                                  editor.selectionStart ==
                                      editor.selectionEnd &&
                                  code[editor.selectionStart].contains(
                                    RegExp(r'[^\[\]()\s]'),
                                  )) {
                                return;
                              }

                              final selectedCode = code.substring(
                                editor.selectionStart,
                                editor.selectionEnd,
                              );

                              e.preventDefault();
                              document.execCommand(
                                'insertText',
                                false,
                                '($selectedCode)',
                              );
                              editor.selectionStart -= 1 + selectedCode.length;
                              editor.selectionEnd -= 1;

                              setState(() {
                                justInsertedMatchingBraces = true;
                              });
                            } else if (e.key == 'Backspace') {
                              if (justInsertedMatchingBraces &&
                                  editor.selectionStart ==
                                      editor.selectionEnd) {
                                e.preventDefault();

                                editor.selectionStart -= 1;
                                editor.selectionEnd = editor.selectionStart + 2;
                                document.execCommand('insertText', false, '');
                              }
                            } else if (e.key == ')') {
                              if (justInsertedMatchingBraces &&
                                  code[editor.selectionStart] == ')') {
                                e.preventDefault();
                                editor.selectionStart++;
                              }
                            } else if (e.key == ']') {
                              if (justInsertedMatchingBraces &&
                                  code[editor.selectionStart] == ']') {
                                e.preventDefault();
                                editor.selectionStart++;
                              }
                            } else if (e.key == 's' && e.ctrlKey) {
                              e.preventDefault();

                              final newSlot = context
                                  .read(slotProvider.notifier)
                                  .createNewSlot(
                                    'Sauvegarde @ ${DateTime.now()}',
                                  );
                              context
                                  .read(currentSlotProvider.notifier)
                                  .setSlot(newSlot);

                              pendingCursorPosition = (
                                editor.selectionStart,
                                editor.selectionEnd,
                              );
                            }
                          },
                          'selectionchange': (e) {
                            final code = context.read(codeProvider);

                            final editor =
                                document.querySelector('#code-input')
                                    as HTMLTextAreaElement;

                            if (editor.selectionStart == editor.selectionEnd &&
                                editor.selectionStart > 0 &&
                                editor.selectionStart < code.length &&
                                ((code[editor.selectionStart - 1] == '[' &&
                                        code[editor.selectionStart] == ']') ||
                                    (code[editor.selectionStart - 1] == '(' &&
                                        code[editor.selectionStart] == ')'))) {
                              // Don't reset matching braces state.
                            } else {
                              setState(() {
                                justInsertedMatchingBraces = false;
                              });
                            }
                          },
                        },
                        onInput: (code) {
                          final editor =
                              document.querySelector('#code-input')
                                  as HTMLTextAreaElement;

                          if (editor.selectionStart == editor.selectionEnd &&
                              editor.selectionStart > 0 &&
                              editor.selectionStart < code.length &&
                              ((code[editor.selectionStart - 1] == '[' &&
                                      code[editor.selectionStart] == ']') ||
                                  (code[editor.selectionStart - 1] == '(' &&
                                      code[editor.selectionStart] == ')'))) {
                            // Don't reset matching braces state.
                          } else {
                            setState(() {
                              justInsertedMatchingBraces = false;
                            });
                          }

                          context
                              .read(codeProvider.notifier)
                              .setStoredCode(code);
                        },
                        [Component.text(initialContent)],
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
                      div(styles: Styles(height: .pixels(300)), [
                        RawText('&ZeroWidthSpace;'),
                      ]),
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
