import 'dart:convert';

import 'package:frontend/components/highlighted_code.dart';
import 'package:http/http.dart' as http;
import 'package:jaspr/jaspr.dart';
import 'package:jaspr/jaspr.dart' as jaspr;
import 'package:markdown/markdown.dart' as md;
import 'package:markdown/markdown.dart';

class Documentation extends StatefulComponent {
  const Documentation({super.key});

  @override
  State createState() => DocumentationState();
}

class DocumentationState extends State<Documentation> {
  final Future<String> documentationFuture = http
      .get(Uri(path: 'doc.md'))
      .then((r) => utf8.decode(r.bodyBytes));

  @override
  Component build(BuildContext context) {
    return div(
      styles: Styles(
        display: .block,
        width: .percent(100),
        height: .percent(100),
        overflow: .only(y: Overflow.scroll),
      ),

      [
        FutureBuilder(
          future: documentationFuture,
          builder: (context, snapshot) {
            final doc = snapshot.data;
            if (doc == null) {
              return div([]);
            }

            final parsedDoc = md.Document(
              encodeHtml: false,
              extensionSet: ExtensionSet.gitHubFlavored,
              blockSyntaxes: [HeaderWithIdSyntax()],
              inlineSyntaxes: [DecodeHtmlSyntax()],
            ).parse(doc);

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
                      raw(HtmlRenderer().render([node])),
                    ]),
              ],
            );
          },
        ),
      ],
    );
  }
}
