import 'dart:convert';

import 'package:frontend/components/huitr_markdown.dart';
import 'package:http/http.dart' as http;
import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

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

            return HuitrMarkdown(markdown: doc);
          },
        ),
      ],
    );
  }
}
