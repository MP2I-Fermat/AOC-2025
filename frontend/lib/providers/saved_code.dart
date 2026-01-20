import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:frontend/providers/current_code.dart';
import 'package:riverpod/riverpod.dart';
import 'package:web/web.dart';

sealed class SaveSlot {
  final String name;
  final String code;

  SaveSlot({required this.name, required this.code});
}

final class Preset extends SaveSlot {
  Preset({required super.name, required super.code});
}

final class UserGenerated extends SaveSlot {
  final int id;

  UserGenerated({required super.name, required super.code, required this.id});

  @override
  bool operator ==(Object other) => other is UserGenerated && other.id == id;

  @override
  int get hashCode => id.hashCode;
}

final slotProvider = NotifierProvider(SavedSlotsNotifier.new);

class SavedSlotsNotifier extends Notifier<List<SaveSlot>> {
  static const storageKey = 'aoc_save_slots';
  static const legacyStorageKey = 'aoc_code';

  static final Preset fizzbuzz = Preset(
    name: 'Fizzbuzz',
    code: '''. A simple fizzbuzz

[
  args, 0 > std::list::nth > n . stores the current value into n
  
  >( . trivial and self-explanatory /s
    n, 15 > std::math::mod, 0 > std::comp::eq,
    ["fizzbuzz" > std::io::print],
    [
      >(
        n, 5 > std::math::mod, 0 > std::comp::eq,
        ["buzz" > std::io::print],
        [
          >(
            n, 3 > std::math::mod, 0 > std::comp::eq,
            ["fizz" > std::io::print],
            [n > std::io::print] > std::test::if
          )
        ] > std::test::if
      )
    ] > std::test::if
  )
  
  >(
    n, 100 > std::comp::eq,
    [.. do nothing ..],
    [n, 1 > std::math::add > fizzbuzz] > std::test::if
  )
] > fizzbuzz

0 > fizzbuzz
''',
  );

  static final List<Preset> presets = [
    fizzbuzz,
    Preset(
      name: 'Aide éditeur',
      code: '''
..
Raccourcis pour l'éditeur:
- Selection du texte+tab: indente toutes les lignes sélectionnées
- Shift+tab: désindente la ligne actuelle ou toutes les lignes sélectionnées
- Ctrl+/: commente la ligne actuelle ou toutes les lignes sélectionnées
- Ctrl+Enter: execute le programme
- Ctrl+S: sauvegarde automatique

We <3 Huitr & COCS
..

"Hello, world!" > std::io::print
''',
    ),
  ];

  List<UserGenerated>? loadUserGenerated() {
    final saved = window.localStorage.getItem(storageKey);
    if (saved == null) return null;

    return (jsonDecode(saved) as List)
        .map(
          (e) => UserGenerated(
            name: e['name'] as String,
            code: e['code'] as String,
            id: e['id'] as int,
          ),
        )
        .toList();
  }

  @override
  List<SaveSlot> build() => [...presets, ...?loadUserGenerated()];

  void _saveState() {
    final encoded = [
      for (final slot in state)
        if (slot case UserGenerated(:final name, :final code, :final id))
          {'name': name, 'code': code, 'id': id},
    ];

    window.localStorage.setItem(storageKey, jsonEncode(encoded));
  }

  UserGenerated createNewSlot(String name) {
    final code = ref.read(codeProvider);

    var id = 0;
    while (state.any((e) {
      if (e case UserGenerated(id: final otherId)) {
        return otherId == id;
      }
      return false;
    })) {
      id++;
    }

    final newSlot = UserGenerated(name: name, code: code, id: id);

    state = [...state, newSlot];

    _saveState();

    return newSlot;
  }

  UserGenerated? updateCode(int id, String code) {
    final idx = state.indexWhere((e) {
      if (e case UserGenerated(id: final otherId)) {
        return id == otherId;
      }
      return false;
    });

    if (idx == -1) return null;

    final newState = List.of(state);
    final newSlot = UserGenerated(name: state[idx].name, code: code, id: id);

    newState[idx] = newSlot;

    state = newState;
    _saveState();

    return newSlot;
  }

  void delete(int id) {
    final idx = state.indexWhere((e) {
      if (e case UserGenerated(id: final otherId)) {
        return id == otherId;
      }
      return false;
    });

    if (idx == -1) return;
    final newState = List.of(state);
    newState.removeAt(idx);

    state = newState;
    _saveState();
  }
}

final currentSlotProvider = NotifierProvider(CurrentSlotNotifier.new);

class CurrentSlotNotifier extends Notifier<SaveSlot?> {
  static final String storageKey = 'current_slot';

  @override
  SaveSlot? build() {
    final rawId = window.localStorage.getItem('current_slot');
    if (rawId == null || rawId == '-1') return null;

    ref.listen(slotProvider, (_, slots) {
      if (!slots.contains(state)) {
        state = null;
      }
    });

    final id = int.parse(rawId);
    return ref.read(slotProvider).firstWhereOrNull((e) {
      if (e case UserGenerated(id: final otherId)) {
        return id == otherId;
      }

      return false;
    });
  }

  void setSlot(SaveSlot? slot) {
    state = slot;

    if (slot case UserGenerated(:final id)) {
      window.localStorage.setItem(storageKey, id.toString());
    } else {
      window.localStorage.setItem(storageKey, '-1');
    }
  }
}
