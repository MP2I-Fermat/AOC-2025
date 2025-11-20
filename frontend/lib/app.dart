import 'dart:js_interop';
import 'dart:js_interop_unsafe';

import 'package:frontend/components/code_editor.dart';
import 'package:frontend/components/information_pane.dart';
import 'package:frontend/components/output.dart';
import 'package:frontend/providers/connection.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_riverpod/jaspr_riverpod.dart';

// The main component of your application.
class App extends StatefulComponent {
  const App({super.key});

  @override
  State createState() => AppState();
}

class AppState extends State<App> {
  final Key resizePaneKey = UniqueKey();
  final Key resizeBarsKey = UniqueKey();
  final Key contentsKey = UniqueKey();

  double? verticalPosition;
  double? horizontalPosition;
  bool resizingWidth = false;
  bool resizingHeight = false;

  @override
  Component build(BuildContext context) {
    final leftBlockFlex = Flex(
      grow: horizontalPosition == null ? 1 : null,
      basis: horizontalPosition == null
          ? .zero
          : .expression('clamp(20%, ${horizontalPosition}px, 80%)'),
    );

    final upperBlockFlex = Flex(
      grow: verticalPosition == null ? 3 : null,
      basis: verticalPosition == null
          ? .zero
          : .expression('clamp(20%, ${verticalPosition}px, 80%)'),
    );

    final zeroPosition = Position.absolute(
      top: .zero,
      bottom: .zero,
      left: .zero,
      right: .zero,
    );

    return div(classes: 'main', [
      div(styles: Styles(height: .vh(100), flexDirection: .column), [
        // relative position provides an anchor for the absolutely positioned
        // elements within.
        div(styles: Styles(position: .relative(), flex: Flex(grow: 1)), [
          if (resizingHeight || resizingWidth)
            div(
              key: resizePaneKey,
              styles: Styles(
                position: zeroPosition,
                zIndex: ZIndex(2),
                cursor: resizingHeight ? .rowResize : .colResize,
                flexDirection: .row,
              ),
              events: {
                'pointerup': (e) {
                  setState(() {
                    resizingHeight = false;
                    resizingWidth = false;
                  });
                },
                'mouseleave': (e) {
                  setState(() {
                    resizingHeight = false;
                    resizingWidth = false;
                  });
                },
                'pointermove': (e) {
                  // TODO: Report PointerEvent coordinates being doubles, not
                  // ints to Dart web team.
                  if (resizingHeight) {
                    setState(() {
                      verticalPosition =
                          (e.getProperty('clientY'.toJS) as JSNumber)
                              .toDartDouble;
                    });
                  } else if (resizingWidth) {
                    setState(() {
                      horizontalPosition =
                          (e.getProperty('clientX'.toJS) as JSNumber)
                              .toDartDouble;
                    });
                  }
                },
              },
              [],
            ),
          div(
            key: resizeBarsKey,
            styles: Styles(
              position: zeroPosition,
              zIndex: ZIndex(1),
              pointerEvents: .none,
              flexDirection: .row,
            ),
            [
              div(styles: Styles(flexDirection: .column, flex: leftBlockFlex), [
                div(styles: Styles(flex: upperBlockFlex), []),
                div(
                  styles: Styles(
                    position: verticalPosition == null
                        ? null
                        : .relative(top: .pixels(-2)),
                    width: .percent(100),
                    height: .pixels(5),
                    cursor: .rowResize,
                    pointerEvents: .all,
                  ),
                  events: {
                    'pointerdown': (e) {
                      setState(() => resizingHeight = true);
                    },
                  },
                  [],
                ),
                div(
                  styles: Styles(flex: Flex(grow: 1, basis: .zero)),
                  [],
                ),
              ]),
              div(
                styles: Styles(
                  position: horizontalPosition == null
                      ? null
                      : .relative(left: .pixels(-2)),
                  width: .pixels(5),
                  height: .percent(100),
                  cursor: .colResize,
                  pointerEvents: .all,
                ),
                events: {
                  'pointerdown': (e) {
                    setState(() => resizingWidth = true);
                  },
                },
                [],
              ),
              div(
                styles: Styles(flex: Flex(grow: 1, basis: .zero)),
                [],
              ),
            ],
          ),
          div(
            key: contentsKey,
            styles: Styles(position: zeroPosition, flexDirection: .row),
            [
              div(styles: Styles(flexDirection: .column, flex: leftBlockFlex), [
                div(styles: Styles(flex: upperBlockFlex), [CodeEditor()]),
                HorizontalBar(),
                div(styles: Styles(flex: Flex(grow: 1, basis: .zero)), [
                  OutputView(),
                ]),
              ]),
              VerticalBar(),
              div(styles: Styles(flex: Flex(grow: 1, basis: .zero)), [
                InfoPane(),
              ]),
            ],
          ),
        ]),
        HorizontalBar(),
        div(styles: Styles(display: .block, height: .pixels(20)), [Footer()]),
      ]),
    ]);
  }
}

class VerticalBar extends StatelessComponent {
  const VerticalBar({super.key});

  @override
  Component build(BuildContext context) {
    return div(classes: 'vertical-bar', []);
  }
}

class HorizontalBar extends StatelessComponent {
  const HorizontalBar({super.key});

  @override
  Component build(BuildContext context) {
    return div(classes: 'horizontal-bar', []);
  }
}

class Footer extends StatelessComponent {
  const Footer({super.key});

  @override
  Component build(BuildContext context) {
    final connection = context.watch(connectionProvider);

    final repoLinks = div([
      a(href: 'https://github.com/MP2I-Fermat/AOC-2025', target: .blank, [
        text('MP2I-Fermat/AOC-2025'),
      ]),
      div(styles: Styles(padding: .symmetric(horizontal: .pixels(8))), [
        raw('&bull;'),
      ]),
      a(href: 'https://github.com/jd-develop/huitr', target: .blank, [
        text('jd-develop/huitr'),
      ]),
    ]);

    final connectionError = switch (connection) {
      AsyncError() => div(styles: Styles(color: Color('red')), [
        text('Pas de connexion'),
      ]),
      AsyncLoading() => div(styles: Styles(color: Color('darkorange')), [
        text('Connexion en cours...'),
      ]),
      AsyncData() => null,
    };

    return div(
      id: 'footer',
      styles: Styles(
        height: .percent(100),
        margin: .symmetric(horizontal: .pixels(8)),
        flexDirection: .row,
        justifyContent: .spaceAround,
        alignItems: .center,
      ),
      [
        connectionError ?? repoLinks,
        div(styles: Styles(flex: Flex(grow: 1)), []),
        a(href: 'https://github.com/abitofevrything', target: .blank, [
          text('abitofevrything'),
        ]),
        div(styles: Styles(padding: .symmetric(horizontal: .pixels(8))), [
          raw('&bull;'),
        ]),
        a(href: 'https://github.com/jd-develop', target: .blank, [
          text('jd-develop'),
        ]),
        div(styles: Styles(padding: .symmetric(horizontal: .pixels(8))), [
          raw('&bull;'),
        ]),
        a(href: 'https://github.com/Hugo-Vangilluwen', target: .blank, [
          text('Hugo-Vangilluwen'),
        ]),
        div(styles: Styles(padding: .symmetric(horizontal: .pixels(8))), [
          raw('&bull;'),
        ]),
        a(href: 'https://github.com/3fxcf9', target: .blank, [text('3fxcf9')]),
      ],
    );
  }
}
