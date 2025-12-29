import 'package:frontend/components/documentation.dart';
import 'package:frontend/components/problems.dart';
import 'package:frontend/components/settings.dart';
import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

class InfoPane extends StatefulComponent {
  const InfoPane({super.key});

  @override
  State createState() => InfoPaneState();
}

enum ActiveTab { settings, problems, documentation }

class InfoPaneState extends State<InfoPane> {
  ActiveTab tab = .settings;

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
        div(
          styles: Styles(
            height: .pixels(40),
            userSelect: .none,
            flexDirection: .row,
          ),
          [
            div(
              styles: Styles(
                height: .percent(100),
                cursor: .pointer,
                justifyContent: .center,
                alignItems: .center,
                flex: Flex(grow: 1, basis: .zero),
              ),
              classes: tab == .settings ? 'tab-selected' : 'tab-unselected',
              events: {
                'click': (_) {
                  setState(() => tab = .settings);
                },
              },
              [Component.text('Paramètres')],
            ),
            div(
              styles: Styles(
                height: .percent(100),
                cursor: .pointer,
                justifyContent: .center,
                alignItems: .center,
                flex: Flex(grow: 1, basis: .zero),
              ),
              classes: tab == .problems ? 'tab-selected' : 'tab-unselected',
              events: {
                'click': (_) {
                  setState(() => tab = .problems);
                },
              },
              [Component.text('Problèmes')],
            ),
            div(
              styles: Styles(
                height: .percent(100),
                cursor: .pointer,
                justifyContent: .center,
                alignItems: .center,
                flex: Flex(grow: 1, basis: .zero),
              ),
              classes: tab == .documentation
                  ? 'tab-selected'
                  : 'tab-unselected',
              events: {
                'click': (_) {
                  setState(() => tab = .documentation);
                },
              },
              [Component.text('Documentation')],
            ),
          ],
        ),
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
                visibility: tab == .settings ? .visible : .hidden,
              ),
              [Settings()],
            ),
            div(
              styles: Styles(
                position: zeroPosition,
                visibility: tab == .problems ? .visible : .hidden,
              ),
              [Problems()],
            ),
            div(
              styles: Styles(
                position: zeroPosition,
                visibility: tab == .documentation ? .visible : .hidden,
              ),
              [Documentation()],
            ),
          ],
        ),
      ],
    );
  }
}
