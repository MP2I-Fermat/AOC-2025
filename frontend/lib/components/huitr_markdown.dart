import 'package:frontend/components/highlighted_code.dart';
import 'package:jaspr/dom.dart';
import 'package:markdown/markdown.dart' as md show Document, Element, Text;

import 'package:jaspr/dom.dart' as jaspr;
import 'package:jaspr/jaspr.dart';
import 'package:markdown/markdown.dart';

class HuitrMarkdown extends StatelessComponent {
  final String markdown;

  const HuitrMarkdown({super.key, required this.markdown});

  @override
  Component build(BuildContext context) {
    final parsedDoc = md.Document(
      encodeHtml: false,
      extensionSet: ExtensionSet.gitHubFlavored,
      blockSyntaxes: [HeaderWithIdSyntax()],
      inlineSyntaxes: [DecodeHtmlSyntax()],
    ).parse(markdown);

    return div(
      styles: Styles(padding: .all(.pixels(8)), flexDirection: .column),
      [
        for (final node in parsedDoc)
          if (node case md.Element(
            tag: 'pre',
            children: [
              md.Element(
                tag: 'code',
                attributes: {'class': 'language-huitr'},
                children: [md.Text(text: final code)],
              ),
            ],
          ))
            pre([
              jaspr.code([HighlightedCode(code: code)]),
            ])
          else
            div([
              RawText(HtmlRenderer().render([node])),
            ]),
      ],
    );
  }
}
