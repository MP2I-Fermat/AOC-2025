import 'dart:convert';

import 'package:common/protocol.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

Future<void> handleConnection(WebSocketChannel channel) async {
  print('Got connection!');

  channel.stream.listen((payload) {
    if (payload is! String) {
      throw Exception('Message was not a string');
    }
    if (payload.length > 1000 * 1000) {
      throw Exception('Message exceeded 1MB limit');
    }
    final message = Message.fromJson(jsonDecode(payload));

    switch (message) {
      case CodeUpdate(:final code):
        print('Got update: $code');
    }
  });
}
