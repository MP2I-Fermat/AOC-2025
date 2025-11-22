import 'package:frontend/providers/state.dart';
import 'package:frontend/providers/users.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_riverpod/jaspr_riverpod.dart';
import 'package:web/web.dart';

class Settings extends StatelessComponent {
  const Settings({super.key});

  @override
  Component build(BuildContext context) {
    final state = context.watch(stateProvider);

    return div(
      styles: Styles(
        width: .percent(100),
        height: .percent(100),
        padding: .all(.pixels(8)),
        boxSizing: .borderBox,
        overflow: .only(y: Overflow.auto),
        flexDirection: .column,
      ),
      [
        switch (state) {
          Writing(:final nick?) => div(styles: Styles(display: .inline), [
            text("Vous êtes en train d'écrire du code avec le pseudo "),
            b([text(nick)]),
            text('.'),
          ]),
          Writing(nick: null) => text(
            "Vous êtes en train d'écrire du code anonymement.",
          ),
          Watching(:final nick) => div(styles: Styles(display: .inline), [
            text("Vous êtes en train de regarder "),
            b([text(nick)]),
            text('.'),
          ]),
          Waiting(:final wantsToWatch) => div(
            styles: Styles(display: .inline),
            [
              text("Vous êtes en train de regarder "),
              b([text(wantsToWatch)]),
              text(", mais il/elle n'est pas en train d'écrire du code."),
            ],
          ),
        },
        PersonalSettings(),
        WatchingSettings(),
      ],
    );
  }
}

class PersonalSettings extends StatefulComponent {
  const PersonalSettings({super.key});

  @override
  State createState() => PersonalSettingsState();
}

class PersonalSettingsState extends State<PersonalSettings> {
  static const nickKey = 'aoc_nick';

  String? nick = window.localStorage.getItem(nickKey);

  @override
  Component build(BuildContext context) {
    final state = context.watch(stateProvider);
    final currentNick = switch (state) {
      Writing(:final nick) => nick,
      _ => null,
    };

    return div(styles: Styles(flexDirection: .column), [
      h3([text('Votre pseudo')]),
      div([
        input(
          id: 'nick-input',
          type: .text,
          value: nick,
          styles: Styles(
            height: .pixels(20),
            padding: .all(.pixels(0)),
            margin: .all(.pixels(8)),
            border: Border.only(
              left: .none(),
              right: .none(),
              top: .none(),
              bottom: BorderSide.solid(
                width: .pixels(1),
                color: Color('white'),
              ),
            ),
            outline: .unset,
            color: Color('var(--primary-color)'),
            fontSize: .unset,
            backgroundColor: .unset,
          ),
          attributes: {'spellcheck': 'false'},
          onInput: (value) {
            setState(() {
              if (value.toString().trim().isEmpty) {
                nick = null;
              } else {
                nick = value.toString();
              }
            });
          },
        ),
        div(
          styles: Styles(
            padding: .all(.pixels(8)),
            cursor: nick != null || currentNick != null
                ? .pointer
                : .notAllowed,
            userSelect: .none,
          ),
          events: {
            'click': (e) {
              if (currentNick?.trim() == nick?.trim()) {
                if (nick != null) {
                  context.read(stateProvider.notifier).write(null);
                  window.localStorage.removeItem(nickKey);
                }

                return;
              }
              context.read(stateProvider.notifier).write(nick?.trim());
              if (nick != null) {
                window.localStorage.setItem(nickKey, nick!.trim());
              } else {
                window.localStorage.removeItem(nickKey);
              }
            },
          },
          [
            switch ((currentNick?.trim(), nick?.trim())) {
              (null, null) => div([text('Entrez un pseudo pour être visible')]),
              (null, String _) => text('Passer en mode visible'),
              (String a, String b) when a != b => text('Changer de pseudo'),
              (String _, null) => text('Passer en mode anonyme'),
              (String _, String _) => text('Passer en mode anonyme'),
            },
          ],
        ),
      ]),
    ]);
  }
}

class WatchingSettings extends StatelessComponent {
  const WatchingSettings({super.key});

  @override
  Component build(BuildContext context) {
    final users = context.watch(usersProvider).entries.toList()
      ..sort((a, b) => a.value.compareTo(b.value));
    final id = context.watch(idProvider);
    final currentlyWatching = switch (context.watch(stateProvider)) {
      Watching(:final id) => id,
      _ => null,
    };

    return div(styles: Styles(flexDirection: .column), [
      h3([text('Autres utilisateurs')]),
      if (users.isEmpty)
        text("Aucun utilisateur n'est en train d'écrire du code.")
      else ...[
        text('Cliquez sur un utilisateur pour les suivre.'),
        ul(styles: Styles(userSelect: .none), [
          for (final MapEntry(:key, :value) in users)
            li(
              styles: Styles(
                cursor: key == currentlyWatching || key == id
                    ? .notAllowed
                    : .pointer,
                fontWeight: key == currentlyWatching ? .bold : .normal,
              ),
              events: {
                'click': (e) {
                  if (key == currentlyWatching || key == id) return;
                  context.read(stateProvider.notifier).watch(key);
                },
              },
              [text(value), if (key == id) text(' (Vous)')],
            ),
        ]),
      ],
    ]);
  }
}
