import 'package:common/protocol.dart';
import 'package:frontend/providers/connection.dart';
import 'package:riverpod/riverpod.dart';

final isRunningProvider = NotifierProvider(RunningNotifier.new);

class RunningNotifier extends Notifier<bool> {
  @override
  bool build() {
    ref.listen(connectionMessagesProvider, (_, message) {
      if (message case AsyncData(value: OutputUpdate(:final output))) {
        state = output != null;
      }
    });

    return false;
  }
}

final outputProvider = NotifierProvider(OutputNotifier.new);

class OutputNotifier extends Notifier<List<OutputLine>> {
  @override
  List<OutputLine> build() {
    ref.listen(connectionMessagesProvider, (_, message) {
      if (message case AsyncData(value: OutputUpdate(:final output?))) {
        state = output;
      }
    });

    return [];
  }
}
