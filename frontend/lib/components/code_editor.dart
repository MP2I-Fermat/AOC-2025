import 'package:jaspr/jaspr.dart';

class CodeEditor extends StatelessComponent {
  const CodeEditor({super.key});

  @override
  Component build(BuildContext context) {
    return div(
      styles: Styles(
        width: .percent(100),
        height: .percent(100),
        justifyContent: .center,
        alignItems: .center,
      ),
      [text('Code Editor')],
    );
  }
}
