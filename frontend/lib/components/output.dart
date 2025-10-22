import 'package:jaspr/jaspr.dart';

class OutputView extends StatelessComponent {
  const OutputView({super.key});

  @override
  Component build(BuildContext context) {
    return div(
      styles: Styles(
        width: .percent(100),
        height: .percent(100),
        justifyContent: .center,
        alignItems: .center,
      ),

      [text('Program Output')],
    );
  }
}
