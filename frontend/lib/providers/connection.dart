import 'dart:async';
import 'dart:convert';
import 'dart:js_interop';

import 'package:common/protocol.dart';
import 'package:frontend/providers/current_code.dart';
import 'package:jaspr_riverpod/jaspr_riverpod.dart';
import 'package:web/web.dart';

final connectionProvider = AsyncNotifierProvider(ConnectionNotifier.new);

class ConnectionNotifier extends AsyncNotifier<WebSocket> {
  static const apiHostOverride = String.fromEnvironment('API_HOST');

  Future<void> connectionLoop() async {
    ref.onDispose(() {
      if (state.unwrapPrevious().value case final socket?) {
        socket.close(1000);
      }
    });

    var backoff = Duration(milliseconds: 500);

    while (ref.mounted) {
      try {
        final connectedCompleter = Completer();
        final closedCompleter = Completer();

        final connection = WebSocket('$apiHostOverride/api/ws');

        state = AsyncLoading();

        connection.onOpen.listen((_) {
          connectedCompleter.complete();
        });

        connection.onClose.listen((_) {
          closedCompleter.complete();
        });

        connection.onError.listen((e) {
          // Bad. But we don't use the error for anything.
          if (!connectedCompleter.isCompleted) {
            connectedCompleter.completeError(Exception());
          } else {
            closedCompleter.completeError(Exception());
          }
        });

        await connectedCompleter.future;

        Timer? debounceTimer;
        final subscription = ref.listen(codeProvider, fireImmediately: true, (
          _,
          _,
        ) {
          debounceTimer ??= Timer(Duration(milliseconds: 200), () {
            connection.send(
              jsonEncode(
                CodeUpdate(code: ref.read(codeProvider)).toJson(),
              ).toJS,
            );

            debounceTimer = null;
          });
        });

        backoff = Duration(milliseconds: 500);

        state = AsyncData(connection);

        await closedCompleter.future.whenComplete(() {
          debounceTimer?.cancel();
          subscription.close();
        });
      } catch (e, s) {
        state = AsyncError(e, s);

        await Future.delayed(backoff);
        backoff *= 2;
        if (backoff > Duration(seconds: 30)) {
          backoff = Duration(seconds: 30);
        }
      }
    }
  }

  // We will manually set the state. Just return a Never future here.
  @override
  Future<Never> build() {
    connectionLoop();
    return Completer<Never>().future;
  }
}
