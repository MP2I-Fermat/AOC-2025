import 'package:frontend/components/documentation.dart';
import 'package:frontend/components/problems.dart';
import 'package:jaspr/jaspr.dart';

class InfoPane extends StatefulComponent {
  const InfoPane({super.key});

  @override
  State createState() => InfoPaneState();
}

class InfoPaneState extends State<InfoPane> {
  bool isOnProblems = true;

  @override
  Component build(BuildContext context) {
    final zeroPosition = Position.absolute(
      top: .zero,
      bottom: .zero,
      left: .zero,
      right: .zero,
    );

    return div(
      styles: Styles(
        width: .percent(100),
        height: .percent(100),
        flexDirection: .column,
      ),

      [
        div(styles: Styles(height: .pixels(40), flexDirection: .row), [
          div(
            styles: Styles(
              height: .percent(100),
              cursor: .pointer,
              justifyContent: .center,
              alignItems: .center,
              flex: Flex(grow: 1, basis: .zero),
            ),
            classes: isOnProblems ? 'tab-selected' : 'tab-unselected',
            events: {
              'click': (_) {
                setState(() => isOnProblems = true);
              },
            },
            [text('Problèmes')],
          ),
          div(
            styles: Styles(
              height: .percent(100),
              cursor: .pointer,
              justifyContent: .center,
              alignItems: .center,
              flex: Flex(grow: 1, basis: .zero),
            ),
            classes: !isOnProblems ? 'tab-selected' : 'tab-unselected',
            events: {
              'click': (_) {
                setState(() => isOnProblems = false);
              },
            },
            [text('Documentation')],
          ),
        ]),
        div(
          styles: Styles(
            position: .relative(),
            justifyContent: .center,
            alignItems: .center,
            flex: Flex(grow: 1),
          ),
          [
            div(
              styles: Styles(
                position: zeroPosition,
                visibility: isOnProblems ? .visible : .hidden,
              ),
              [Problems()],
            ),
            div(
              styles: Styles(
                position: zeroPosition,
                visibility: !isOnProblems ? .visible : .hidden,
              ),
              [Documentation()],
            ),
          ],
        ),
      ],
    );
  }
}
