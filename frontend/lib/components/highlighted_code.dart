import 'dart:collection';

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

class HighlightedCode extends StatefulComponent {
  final String code;

  const HighlightedCode({required this.code, super.key});

  @override
  State<HighlightedCode> createState() => _HighlightedCodeState();
}

class _HighlightedCodeState extends State<HighlightedCode> {
  late List<(HuitrToken, String)> tokens;

  @override
  void initState() {
    super.initState();

    tokens = tokenize(huitrRules, component.code);
  }

  @override
  void didUpdateComponent(covariant HighlightedCode oldComponent) {
    super.didUpdateComponent(oldComponent);
    tokens = tokenize(huitrRules, component.code);
  }

  @override
  Component build(BuildContext context) {
    var inSingleComment = false;
    var inMultiComment = false;

    final parenQueue = DoubleLinkedQueue<HuitrToken>();
    final parenColors = [
      Color.variable('--paren-color-1'),
      Color.variable('--paren-color-2'),
      Color.variable('--paren-color-3'),
    ];

    return span(
      styles: Styles(whiteSpace: .pre, raw: {'font-family': 'monospace'}),
      [
        ...tokens.indexed.map((r) {
          final (index, (type, value)) = r;

          if (type == HuitrToken.singleCommentStart && !inMultiComment) {
            inSingleComment = true;
          }

          if (type == HuitrToken.newline) {
            inSingleComment = false;
          }

          if (type == HuitrToken.multiCommentStart && !inSingleComment) {
            inMultiComment = !inMultiComment;
          }

          final Color color;
          if (inSingleComment || inMultiComment) {
            color = Color.variable('--comment-color');
          } else {
            color = switch (type) {
              HuitrToken.ident =>
                index < tokens.length - 1 &&
                        tokens[index + 1].$1 == HuitrToken.nameSp
                    ? Color.variable('--namespace-color')
                    : Color.variable('--ident-color'),
              HuitrToken.integerLiteral => Color.variable('--number-literal'),
              HuitrToken.floatLiteral => Color.variable('--number-literal'),
              HuitrToken.stringLiteral || HuitrToken.multilineStringLiteral =>
                Color.variable('--string-color'),
              HuitrToken.whitespace => Color.variable('--default-color'),
              HuitrToken.newline => Color.variable('--default-color'),
              HuitrToken.comma => Color.variable('--default-color'),
              HuitrToken.semicolon => Color.variable('--default-color'),
              HuitrToken.lParen || HuitrToken.lSquare => () {
                parenQueue.addLast(type);
                return parenColors[parenQueue.length % parenColors.length];
              }(),
              HuitrToken.rParen => () {
                if (parenQueue.lastOrNull != HuitrToken.lParen) {
                  return Color.variable('--error-color');
                }

                final color =
                    parenColors[parenQueue.length % parenColors.length];
                parenQueue.removeLast();
                return color;
              }(),
              HuitrToken.rSquare => () {
                if (parenQueue.lastOrNull != HuitrToken.lSquare) {
                  return Color.variable('--error-color');
                }

                final color =
                    parenColors[parenQueue.length % parenColors.length];
                parenQueue.removeLast();
                return color;
              }(),
              HuitrToken.chainOp => Color.variable('--default-color'),
              HuitrToken.nameSp => Color.variable('--namespace-color'),
              HuitrToken.singleCommentStart => Color.variable(
                '--comment-color',
              ),
              HuitrToken.multiCommentStart => Color.variable('--comment-color'),
              HuitrToken.unrecognizable => Color.variable('--error-color'),
            };
          }

          return div(styles: Styles(display: .inline, color: color), [
            Component.text(value),
          ]);
        }),
      ],
    );
  }
}

enum HuitrToken {
  ident,
  integerLiteral,
  floatLiteral,
  stringLiteral,
  multilineStringLiteral,
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
  semicolon,
  unrecognizable,
}

final huitrRules = [
  (RegExp(r'[A-Za-z_][A-Za-z0-9_]*'), HuitrToken.ident),

  // The [0-9]+ case must be last, or else it matches the leading 0 in 0x, 0o
  // or 0b, and returns early.
  (
    RegExp(r'-?((0[xX][0-9A-Fa-f]+)|(0[oO][0-7]+)|(0[bB][0-1]+)|[0-9]+)'),
    HuitrToken.integerLiteral,
  ),
  (RegExp(r'-?[0-9]+(\.[0-9]*)?([eE][\+-]?[0-9]+)?'), HuitrToken.floatLiteral),

  (
    RegExp(
      r'"([ !$-\[\]-~\u00e0\u00e2\u00e7\u00e9\u00e8\u00ea\u00eb\u00ee\u00ef\u00f4\u00f6\u00f9\u00fb\u00fc\u00ff\u00e6\u0153\u00c0\u00c2\u00c7\u00c9\u00c8\u00ca\u00cb\u00ce\u00cf\u00d4\u00d6\u00d9\u00db\u00dc\u0178\u00c6\u0152\u2019\u00a0\u202f]|(\\[\\"ntbr])|(\\u[0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F]))*"',
    ),
    HuitrToken.stringLiteral,
  ),

  (
    RegExp(
      r'"""(("|"")?([ !$-\[\]-~\n\u00e0\u00e2\u00e7\u00e9\u00e8\u00ea\u00eb\u00ee\u00ef\u00f4\u00f6\u00f9\u00fb\u00fc\u00ff\u00e6\u0153\u00c0\u00c2\u00c7\u00c9\u00c8\u00ca\u00cb\u00ce\u00cf\u00d4\u00d6\u00d9\u00db\u00dc\u0178\u00c6\u0152\u2019\u00a0\u202f]|(\\[\\"ntbr])|(\\u[0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F])))*"""',
    ),
    HuitrToken.multilineStringLiteral,
  ),

  (RegExp(r'( |\t)+'), HuitrToken.whitespace),

  (RegExp(r'\.'), HuitrToken.singleCommentStart),
  (RegExp(r'\.\.'), HuitrToken.multiCommentStart),

  (RegExp(r'\n'), HuitrToken.newline),
  (RegExp(r';'), HuitrToken.semicolon),
  (RegExp(r','), HuitrToken.comma),
  (RegExp(r'\('), HuitrToken.lParen),
  (RegExp(r'\)'), HuitrToken.rParen),
  (RegExp(r'\['), HuitrToken.lSquare),
  (RegExp(r'\]'), HuitrToken.rSquare),
  (RegExp(r'>'), HuitrToken.chainOp),
  (RegExp(r'::'), HuitrToken.nameSp),
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
