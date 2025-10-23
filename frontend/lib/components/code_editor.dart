import 'package:jaspr/jaspr.dart';
import 'package:web/web.dart';

class CodeEditor extends StatefulComponent {
  const CodeEditor({super.key});

  @override
  State createState() => CodeEditorState();
}

class CodeEditorState extends State<CodeEditor> {
  static const initialContent = r'''# Some test code
if [ -d some_directory ]; then
  echo "Test!"
  exit 1
fi

''';
  var content = initialContent;
  var verticalScrollOffset = 0.0;

  @override
  Component build(BuildContext context) {
    var lineCount = '\n'.allMatches(content).length + 1;
    // contenteditable adds newlines.
    if (content.endsWith('\n')) lineCount--;

    return div(
      styles: Styles(
        position: .relative(),
        width: .percent(100),
        height: .percent(100),
        fontFamily: .new('monospace'),
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
                    div(
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
                        outline: Outline(style: .none),
                        // Opacity 0 hides the cursor, just render the text as
                        // transparent instead.
                        color: .rgba(0, 0, 0, 0),
                        whiteSpace: .pre,
                        raw: {'caret-color': 'var(--primary-color)'},
                      ),
                      attributes: {
                        'contenteditable': 'plaintext-only',
                        'spellcheck': 'false',
                      },
                      events: {
                        'input': (e) {
                          final input =
                              document.querySelector('#code-input')
                                  as HTMLElement;

                          setState(() => content = input.innerText);
                        },
                      },
                      [text(initialContent)],
                    ),
                    div(
                      styles: Styles(
                        display: .inline,
                        zIndex: ZIndex(0),
                        whiteSpace: .pre,
                      ),
                      [HighlightedCode(content)],
                    ),
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

class HighlightedCode extends StatefulComponent {
  final String code;

  const HighlightedCode(this.code, {super.key});

  @override
  State<HighlightedCode> createState() => _HighlightedCodeState();
}

class _HighlightedCodeState extends State<HighlightedCode> {
  @override
  bool shouldRebuild(covariant HighlightedCode newComponent) =>
      newComponent.code != component.code;

  @override
  Component build(BuildContext context) {
    var isFirstInLine = true;

    return fragment(
      tokenize(shRules, component.code).map((r) {
        final (type, value) = r;

        var wordColor = Color('white');
        if (type == ShToken.word) {
          if (isFirstInLine) {
            wordColor = Color('yellow');
            isFirstInLine = false;
          }
        } else if (type == ShToken.whitespace && value.contains('\n')) {
          isFirstInLine = true;
        }

        return div(
          styles: Styles(
            display: .inline,
            color: switch (type) {
              .whitespace || .word => wordColor,
              .string => Color('maroon'),
              .number => Color('aqua'),
              .control => Color('purple'),
              .comment => Color('green'),
            },
          ),
          [text(value)],
        );
      }).toList(),
    );
  }
}

enum ShToken { whitespace, string, number, control, word, comment }

final shRules = [
  (RegExp(r'\s+'), ShToken.whitespace),
  (RegExp(r'"([^"\\]|\\.)*"'), ShToken.string),
  (RegExp(r'[+-]?\d+'), ShToken.number),
  (RegExp(r'if|then|else|elif|fi|while|do|function|\[|\]'), ShToken.control),
  (RegExp(r'[-\w]+'), ShToken.word),
  (RegExp(r'#[^\n]*'), ShToken.comment),
  (RegExp(r'.'), ShToken.word),
];

List<(T, String)> tokenize<T>(List<(RegExp, T)> rules, String input) {
  final result = <(T, String)>[];

  var offset = 0;
  while (offset < input.length) {
    T? longestType;
    int longestLength = 0;

    for (final (pattern, type) in rules) {
      final match = pattern.matchAsPrefix(input, offset);
      if (match == null) continue;

      final value = match.group(0)!;
      if (value.length > longestLength) {
        longestLength = value.length;
        longestType = type;
      }
    }

    if (longestType == null || longestLength == 0) {
      throw 'aaaa tokenization failed';
    }

    result.add((longestType, input.substring(offset, offset + longestLength)));
    offset += longestLength;
  }

  return result;
}
