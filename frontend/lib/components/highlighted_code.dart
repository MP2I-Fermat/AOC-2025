import 'dart:collection';

import 'package:jaspr/jaspr.dart';

class HighlightedCode extends StatelessComponent {
  final String code;

  HighlightedCode({required this.code});

  @override
  Component build(BuildContext context) {
    var inSingleComment = false;
    var inMultiComment = false;

    final tokens = tokenize(huitrRules, code);

    final parenQueue = DoubleLinkedQueue<HuitrToken>();
    final parenColors = [
      Color('fuchsia'),
      Color('yellow'),
      Color('cornflowerblue'),
    ];

    return div(
      styles: Styles(
        display: .inline,
        whiteSpace: .pre,
        raw: {'font-family': 'monospace'},
      ),
      [
        ...tokens.indexed.map((r) {
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
              HuitrToken.lParen || HuitrToken.lSquare => () {
                parenQueue.addLast(type);
                return parenColors[parenQueue.length % parenColors.length];
              }(),
              HuitrToken.rParen => () {
                if (parenQueue.lastOrNull != HuitrToken.lParen) {
                  return Color('red');
                }

                final color =
                    parenColors[parenQueue.length % parenColors.length];
                parenQueue.removeLast();
                return color;
              }(),
              HuitrToken.rSquare => () {
                if (parenQueue.lastOrNull != HuitrToken.lSquare) {
                  return Color('red');
                }

                final color =
                    parenColors[parenQueue.length % parenColors.length];
                parenQueue.removeLast();
                return color;
              }(),
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
