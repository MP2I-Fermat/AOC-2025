import 'package:common/protocol.dart';
import 'package:frontend/providers/connection.dart';
import 'package:jaspr_riverpod/jaspr_riverpod.dart';

final problemStateProvider = NotifierProvider(ProblemStateNotifier.new);

class ProblemStateNotifier extends Notifier<Map<String, ProblemInfo>> {
  @override
  Map<String, ProblemInfo> build() {
    ref.listen(connectionMessagesProvider, (_, message) {
      if (message.value case ProblemsUpdate(:final problems)) {
        state = problems;
      }
    });

    return {};
  }
}
