import 'package:frontend/providers/current_code.dart';
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
  late final initialContent = context.read(codeProvider);

  @override
  Component build(BuildContext context) {
    final content = context.watch(codeProvider);

    var lineCount = '\n'.allMatches(content).length + 1;
    // contenteditable adds newlines.
    if (content.endsWith('\n')) lineCount--;

    return div(
      styles: Styles(
        position: .relative(),
        width: .percent(100),
        height: .percent(100),
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

                          context
                              .read(codeProvider.notifier)
                              .setCode(input.innerText);
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
                      [HighlightedCode()],
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

class HighlightedCode extends StatelessComponent {
  @override
  Component build(BuildContext context) {
    final code = context.watch(codeProvider);

    var inSingleComment = false;
    var inMultiComment = false;

    final tokens = tokenize(huitrRules, code);

    return fragment(
      tokens.indexed.map((r) {
        final (index, (type, value)) = r;

        if (type == HuitrToken.singleCommentStart) {
          inSingleComment = true;
        }

        if (value == '\n') {
          inSingleComment = false;
        }

        if (type == HuitrToken.multiCommentStart) {
          inMultiComment = !inMultiComment;
        }

        var color = Color('white');
        if (inSingleComment || inMultiComment) {
          color = Color('green');
        } else {
          color = switch (type) {
            HuitrToken.ident =>
              index < tokens.length - 1 &&
                      tokens[index + 1].$1 == HuitrToken.nameSp
                  ? Color('purple')
                  : Color('aqua'),
            HuitrToken.integerLiteral => Color('yellow'),
            HuitrToken.floatLiteral => Color('yellow'),
            HuitrToken.stringLiteral => Color('orange'),
            HuitrToken.whitespace => Color('white'),
            HuitrToken.newline => Color('white'),
            HuitrToken.comma => Color('white'),
            HuitrToken.lParen => Color('fuchsia'),
            HuitrToken.rParen => Color('fuchsia'),
            HuitrToken.lSquare => Color('fuchsia'),
            HuitrToken.rSquare => Color('fuchsia'),
            HuitrToken.chainOp => Color('white'),
            HuitrToken.nameSp => Color('purple'),
            HuitrToken.singleCommentStart => Color('green'),
            HuitrToken.multiCommentStart => Color('green'),
            HuitrToken.unrecognizable => Color('red'),
          };
        }

        return div(styles: Styles(display: .inline, color: color), [
          text(value),
        ]);
      }).toList(),
    );
  }
}

enum HuitrToken {
  ident,
  integerLiteral,
  floatLiteral,
  stringLiteral,
  whitespace,
  newline,
  comma,
  lParen,
  rParen,
  lSquare,
  rSquare,
  chainOp,
  nameSp,
  singleCommentStart,
  multiCommentStart,
  unrecognizable,
}

final huitrRules = [
  (RegExp(r'[A-Za-z][A-Za-z0-9_]*'), HuitrToken.ident),
  (
    RegExp(r'-?([0-9]+|(0[xX][0-9A-Fa-f]+)|(0[oO][0-7]+)|(0[bB][0-1]+))'),
    HuitrToken.integerLiteral,
  ),
  (RegExp(r'-?[0-9]+(\.[0-9]*)?([eE][\+-]?[0-9]+)?'), HuitrToken.floatLiteral),
  (RegExp(r'"([ !$-~]|(\\"))*"'), HuitrToken.stringLiteral),
  (RegExp(r'( |\t)+'), HuitrToken.whitespace),
  (RegExp(r';|\n'), HuitrToken.newline),
  (RegExp(r','), HuitrToken.comma),
  (RegExp(r'\('), HuitrToken.lParen),
  (RegExp(r'\)'), HuitrToken.rParen),
  (RegExp(r'\['), HuitrToken.lSquare),
  (RegExp(r'\]'), HuitrToken.rSquare),
  (RegExp(r'>'), HuitrToken.chainOp),
  (RegExp(r'::'), HuitrToken.nameSp),
  (RegExp(r'\.'), HuitrToken.singleCommentStart),
  (RegExp(r'\.\.'), HuitrToken.multiCommentStart),
  (RegExp(r'.'), HuitrToken.unrecognizable),
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
