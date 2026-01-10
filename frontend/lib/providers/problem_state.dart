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
        final previousProblems = state.entries
            .where((p) => p.value.unlocked)
            .map((p) => p.key)
            .sorted();

        if (previousProblems.isNotEmpty) {
          final orderedProblems = problems.entries
              .where((p) => p.value.unlocked)
              .map((p) => p.key)
              .sorted();

          final previousLastIndex = orderedProblems.indexOf(
            previousProblems.last,
          );

          if (previousLastIndex != -1 &&
              previousLastIndex < orderedProblems.length - 1) {
            final name =
                'Sauvegarde automatique: Solution partie ${previousProblems.length}';

            if (!ref.read(slotProvider).any((slot) => slot.name == name)) {
              ref.read(slotProvider.notifier).createNewSlot(name);
            }
          }
        }

        state = problems;
      }
    });

    return {};
  }
}
