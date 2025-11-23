import 'dart:async';

import 'package:common/protocol.dart';
import 'package:frontend/providers/connection.dart';
import 'package:frontend/providers/current_code.dart';
import 'package:frontend/providers/users.dart';
import 'package:riverpod/riverpod.dart';

sealed class ClientState {}

final class Waiting extends ClientState {
  final String wantsToWatch;

  Waiting({required this.wantsToWatch});
}

final class Writing extends ClientState {
  final String? nick;

  Writing({required this.nick});
}

final class Watching extends ClientState {
  final int id;
  final String nick;

  Watching({required this.id, required this.nick});
}

final stateProvider = NotifierProvider(StateNotifier.new);

class StateNotifier extends Notifier<ClientState> {
  Timer? codeDebounceTimer;
  ProviderSubscription? codeUpdateSubscription;

  void cancelCodeUpdates() {
    codeDebounceTimer?.cancel();
    codeDebounceTimer = null;
    codeUpdateSubscription?.close();
    codeUpdateSubscription = null;
  }

  @override
  ClientState build() {
    ref.listen(connectionProvider, (_, connectionState) {
      final connection = connectionState.unwrapPrevious().value;
      if (connection == null) {
        cancelCodeUpdates();
        return;
      }

      if (state case Watching(:final id)) {
        connection.send(Message.watch(id: id));
      } else if (state case Writing(:final nick)) {
        connection.send(Message.startWritingCode(nick: nick));
        setupSendingCodeUpdates(connection);
      }
    });

    ref.listen(usersProvider, (_, users) {
      if (state case Watching(:final id, :final nick)) {
        final currentNick = users[id]?.nick;

        if (currentNick == null) {
          final matching = users.entries
              .where((e) => e.value.nick == nick)
              .singleOrNull;

          if (matching != null) {
            watch(matching.key);
          } else {
            state = Waiting(wantsToWatch: nick);
          }
        } else if (currentNick != nick) {
          watch(id);
        }
      } else if (state case Waiting(:final wantsToWatch)) {
        final matching = users.entries
            .where((e) => e.value.nick == wantsToWatch)
            .singleOrNull;

        if (matching != null) {
          watch(matching.key);
        }
      }
    });

    return Writing(nick: null);
  }

  void setupReceivingCodeUpdates() {
    codeUpdateSubscription = ref.listen<AsyncValue<Message>>(
      connectionMessagesProvider,
      (_, msg) {
        if (msg.value case CodeUpdate msg) {
          ref.read(codeProvider.notifier).setDisplayedCode(msg.code);
        }
      },
    );
  }

  void watch(int id) {
    final info = ref.read(usersProvider)[id];
    if (info == null) return;

    cancelCodeUpdates();
    setupReceivingCodeUpdates();

    state = Watching(id: id, nick: info.nick);
    if (ref.read(connectionProvider).unwrapPrevious().value
        case final connection?) {
      connection.send(Message.watch(id: id));
    }
  }

  void setupSendingCodeUpdates(Connection connection) {
    codeUpdateSubscription = ref.listen(codeProvider, fireImmediately: true, (
      _,
      _,
    ) {
      codeDebounceTimer ??= Timer(Duration(milliseconds: 200), () {
        connection.send(CodeUpdate(code: ref.read(codeProvider)));

        codeDebounceTimer = null;
      });
    });
  }

  void write(String? nick) {
    ref.read(codeProvider.notifier).restoreStoredCode();

    cancelCodeUpdates();

    state = Writing(nick: nick);
    if (ref.read(connectionProvider).unwrapPrevious().value
        case final connection?) {
      connection.send(Message.startWritingCode(nick: nick));
      if (nick != null) {
        setupSendingCodeUpdates(connection);
      }
    }
  }
}
