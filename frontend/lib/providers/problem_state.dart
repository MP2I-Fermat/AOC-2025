import 'package:collection/collection.dart';
import 'package:common/protocol.dart';
import 'package:frontend/providers/connection.dart';
import 'package:frontend/providers/saved_code.dart';
import 'package:jaspr_riverpod/jaspr_riverpod.dart';

final problemStateProvider = NotifierProvider(ProblemStateNotifier.new);

class ProblemStateNotifier extends Notifier<Map<String, ProblemInfo>> {
  @override
  Map<String, ProblemInfo> build() {
    ref.listen(connectionMessagesProvider, (_, message) {
      if (message.value case ProblemsUpdate(:final problems)) {
        final orderedProblems = problems.keys.sorted();

        for (final MapEntry(key: name, value: problem) in problems.entries) {
          final isSolved = problem.testCaseStatus.every(
            (status) => status == TestStatus.success,
          );
          if (!isSolved) continue;

          final previouslySolved = state[name]?.testCaseStatus.every(
            (status) => status == TestStatus.success,
          );
          if (previouslySolved == true) continue;

          final slotName =
              'Sauvegarde automatique : Solution partie ${orderedProblems.indexOf(name) + 1}';

          if (!ref.read(slotProvider).any((slot) => slot.name == slotName)) {
            ref.read(slotProvider.notifier).createNewSlot(slotName);
          }
        }

        state = {
          ...problems,
          for (final MapEntry(:key, :value) in state.entries)
            // Prevent problems from being re-locked.
            // Can happen when connection is resumed.
            if (value.unlocked && problems[key]?.unlocked == false) key: value,
        };
      }
    });

    return {};
  }
}
