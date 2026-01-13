import 'package:common/protocol.dart';
import 'package:frontend/components/problems.dart';
import 'package:frontend/providers/current_code.dart';
import 'package:frontend/providers/saved_code.dart';
import 'package:frontend/providers/state.dart';
import 'package:frontend/providers/users.dart';
import 'package:jaspr/dom.dart';
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
        overflow: .only(y: Overflow.auto, x: Overflow.hidden),
        flexDirection: .column,
        raw: {'overflow-wrap': 'anywhere'},
      ),
      [
        switch (state) {
          Writing(:final nick?) => div(styles: Styles(display: .inline), [
            Component.text(
              "Vous êtes en train d'écrire du code avec le pseudo ",
            ),
            b([Component.text(nick)]),
            Component.text('.'),
          ]),
          Writing(nick: null) => Component.text(
            "Vous êtes en train d'écrire du code anonymement.",
          ),
          Watching(:final nick) => div(styles: Styles(display: .inline), [
            Component.text("Vous êtes en train de regarder "),
            b([Component.text(nick)]),
            Component.text('.'),
          ]),
          Waiting(:final wantsToWatch) => div(
            styles: Styles(display: .inline),
            [
              Component.text("Vous êtes en train de regarder "),
              b([Component.text(wantsToWatch)]),
              Component.text(
                ", mais il/elle n'est pas en train d'écrire du code.",
              ),
            ],
          ),
        },
        PersonalSettings(),
        WatchingSettings(),
        SlotSettings(),
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
      h3([Component.text('Votre pseudo')]),
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
              (null, null) => div([
                Component.text('Entrez un pseudo pour être visible'),
              ]),
              (null, String _) => Component.text('Passer en mode visible'),
              (String a, String b) when a != b => Component.text(
                'Changer de pseudo',
              ),
              (String _, null) => Component.text('Passer en mode anonyme'),
              (String _, String _) => Component.text('Passer en mode anonyme'),
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
      ..sort((a, b) => a.value.nick.compareTo(b.value.nick));
    final id = context.watch(idProvider);
    final currentlyWatching = switch (context.watch(stateProvider)) {
      Watching(:final id) => id,
      _ => null,
    };

    return div(styles: Styles(flexDirection: .column), [
      h3([Component.text('Autres utilisateurs')]),
      if (users.isEmpty)
        Component.text("Aucun utilisateur n'est en train d'écrire du code.")
      else ...[
        Component.text('Cliquez sur un utilisateur pour les suivre.'),
        if (context.read(usersProvider)[currentlyWatching] case UserInfo(
          :final nick,
        ))
          div(styles: Styles(display: .inline), [
            Component.text('Cliquez encore une fois sur '),
            b([Component.text(nick)]),
            Component.text(' pour repasser en édition anonyme.'),
          ]),
        ul(styles: Styles(userSelect: .none), [
          for (final MapEntry(:key, :value) in users)
            li(
              styles: Styles(
                cursor: key == id ? .notAllowed : .pointer,
                fontWeight: key == currentlyWatching ? .bold : .normal,
              ),
              events: {
                'click': (e) {
                  if (key == id) return;
                  if (key == currentlyWatching) {
                    context.read(stateProvider.notifier).write(null);
                  } else {
                    context.read(stateProvider.notifier).watch(key);
                  }
                },
              },
              [
                Component.text(value.nick),
                if (key == id) Component.text(' (Vous)'),
                if (value.numViewers != 0)
                  Component.text(
                    ' (${value.numViewers} spectateur${value.numViewers == 1 ? '' : 's'})',
                  ),
                Component.text(' - Partie ${value.problemNumber} -'),
                TestStatusIcon(status: value.displayStatus),
              ],
            ),
        ]),
      ],
    ]);
  }
}

class SlotSettings extends StatelessComponent {
  @override
  Component build(BuildContext context) {
    final state = context.watch(stateProvider);

    return div(styles: Styles(flexDirection: .column), [
      h3([Component.text('Sauvegarde')]),
      if (state case Writing()) ...[
        Component.text(
          'Sélectionnez une sauvegarde à restaurer où a mettre à jour.',
        ),
        br(),
        Component.text(
          "Attention, la restauration d'une sauvegarde supprimera votre code actuel. Pensez à le sauvegarder si besoin.",
        ),
        SlotCreator(),
        ul(styles: Styles(userSelect: .none), [
          for (final slot in context.watch(slotProvider))
            li(
              styles: Styles(
                fontWeight: slot == context.watch(currentSlotProvider)
                    ? .bold
                    : .normal,
              ),
              [
                span([Component.text(slot.name)]),
                span(
                  styles: Styles(
                    cursor: slot == context.watch(currentSlotProvider)
                        ? .notAllowed
                        : .pointer,
                  ),
                  events: {
                    'click': (_) => context
                        .read(codeProvider.notifier)
                        .restoreFromSlot(slot),
                  },
                  [Component.text(' [Restaurer]')],
                ),
                switch (slot) {
                  Preset() => span(styles: Styles(cursor: .notAllowed), [
                    Component.text(' (Lecture seule)'),
                  ]),
                  UserGenerated(:final id) => Component.fragment([
                    span(
                      styles: Styles(cursor: .pointer),
                      events: {
                        'click': (_) {
                          final newSlot = context
                              .read(slotProvider.notifier)
                              .updateCode(id, context.read(codeProvider));
                          context
                              .read(currentSlotProvider.notifier)
                              .setSlot(newSlot);
                        },
                      },
                      [Component.text(' [Mettre à jour]')],
                    ),
                    span(
                      styles: Styles(cursor: .pointer),
                      events: {
                        'click': (_) {
                          context.read(slotProvider.notifier).delete(id);
                        },
                      },
                      [Component.text(' [Supprimer]')],
                    ),
                  ]),
                },
              ],
            ),
        ]),
      ] else
        Component.text('Passez en mode édition pour voir vos sauvegardes.'),
    ]);
  }
}

class SlotCreator extends StatefulComponent {
  const SlotCreator({super.key});

  @override
  State<SlotCreator> createState() => SlotCreatorState();
}

class SlotCreatorState extends State<SlotCreator> {
  String name = '';

  @override
  Component build(BuildContext context) {
    final nameIsValid = name.trim().isNotEmpty;

    return div([
      input(
        type: .text,
        styles: Styles(
          height: .pixels(20),
          padding: .all(.pixels(0)),
          margin: .all(.pixels(8)),
          border: Border.only(
            left: .none(),
            right: .none(),
            top: .none(),
            bottom: BorderSide.solid(width: .pixels(1), color: Color('white')),
          ),
          outline: .unset,
          color: Color('var(--primary-color)'),
          fontSize: .unset,
          backgroundColor: .unset,
        ),
        attributes: {'spellcheck': 'false'},
        value: name,
        onInput: (n) => setState(() {
          name = n as String;
        }),
      ),
      div(
        styles: Styles(
          cursor: nameIsValid ? .pointer : .notAllowed,
          userSelect: .none,
          alignItems: .center,
        ),
        events: {
          'click': (_) {
            if (!nameIsValid) return;

            context.read(slotProvider.notifier).createNewSlot(name);
            setState(() {
              name = '';
            });
          },
        },
        [Component.text('Créer une nouvelle sauvegarde')],
      ),
    ]);
  }
}
