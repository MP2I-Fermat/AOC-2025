import 'dart:async';

import 'package:common/protocol.dart';
import 'package:frontend/providers/connection.dart';
import 'package:jaspr_riverpod/jaspr_riverpod.dart';

final userUpdateMessageProvider = StreamProvider((ref) {
  final controller = StreamController<UsersUpdate>();
  ref.listen(connectionMessagesProvider, (_, msg) {
    if (msg case AsyncData(value: UsersUpdate message)) {
      controller.add(message);
    }
  });
  return controller.stream;
});

final usersProvider = Provider<Map<int, String>>((ref) {
  final lastMessage = ref.watch(userUpdateMessageProvider);
  if (lastMessage.value case final msg?) {
    return msg.users;
  }

  return {};
});

final idProvider = Provider((ref) {
  final lastMessage = ref.watch(userUpdateMessageProvider);
  if (lastMessage.value case final msg?) {
    return msg.yourId;
  }

  return null;
});
