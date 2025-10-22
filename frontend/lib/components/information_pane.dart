import 'package:jaspr/jaspr.dart';

class InfoPane extends StatelessComponent {
  const InfoPane({super.key});

  @override
  Component build(BuildContext context) {
    return div(
      styles: Styles(
        width: .percent(100),
        height: .percent(100),
        justifyContent: .center,
        alignItems: .center,
      ),

      [text('Information Pane')],
    );
  }
}
