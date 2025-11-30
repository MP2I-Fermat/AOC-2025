import 'dart:async';

import 'package:frontend/providers/saved_code.dart';
import 'package:jaspr_riverpod/jaspr_riverpod.dart';
import 'package:web/web.dart';

final codeProvider = NotifierProvider(CodeProvider.new);

class CodeProvider extends Notifier<String> {
  static const storageKey = 'aoc_code';

  @override
  String build() {
    if (window.localStorage.getItem(storageKey) case final code?) {
      return code;
    }

    if (ref.read(currentSlotProvider) case final slot?) {
      return slot.code;
    }

    scheduleMicrotask(() => restoreFromSlot(SavedSlotsNotifier.fizzbuzz));
    return SavedSlotsNotifier.fizzbuzz.code;
  }

  void setStoredCode(String code) {
    if (code != ref.read(currentSlotProvider)?.code) {
      ref.read(currentSlotProvider.notifier).setSlot(null);
    }

    window.localStorage.setItem(storageKey, code);

    state = code;
  }

  void restoreStoredCode() {
    state = build();
  }

  void restoreFromSlot(SaveSlot slot) {
    ref.read(currentSlotProvider.notifier).setSlot(slot);
    setStoredCode(slot.code);
  }

  void setDisplayedCode(String code) {
    state = code;
  }
}
