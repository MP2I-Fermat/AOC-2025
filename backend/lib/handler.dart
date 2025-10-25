import 'dart:convert';

import 'package:backend/evaluation.dart';
import 'package:common/protocol.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ConnectionHandler {
  final Set<ConnectionState> connections = {};

  Future<void> handle(WebSocketChannel channel) async {
    final state = ConnectionState(channel);
    connections.add(state);

    EditingState requireEditing() => state.clientState as EditingState;

    try {
      await for (final payload in channel.stream) {
        if (payload is! String) {
          throw Exception('Message was not a string');
        }
        if (payload.length > 1000 * 1000) {
          throw Exception('Message exceeded 1MB limit');
        }
        final message = Message.fromJson(jsonDecode(payload));

        switch (message) {
          case CodeUpdate(:final code):
            requireEditing().code = code;
          case StartEvaluation(:final code):
            final editingState = requireEditing();
            await editingState.activeEvaluation?.cancel();
            editingState.code = code;
            await editingState.startEvaluation();
        }
      }
    } finally {
      connections.remove(state);
    }
  }
}

class ConnectionState {
  final WebSocketChannel channel;

  ClientState clientState = EditingState();

  ConnectionState(this.channel);
}

sealed class ClientState {}

final class EditingState extends ClientState {
  String code = '';

  Evaluation? activeEvaluation;

  Future<Evaluation> startEvaluation() async =>
      activeEvaluation = await Evaluation.evaluate(code);
}
