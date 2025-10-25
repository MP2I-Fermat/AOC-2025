import 'package:freezed_annotation/freezed_annotation.dart';

part 'protocol.g.dart';
part 'protocol.freezed.dart';

@freezed
sealed class Message with _$Message {
  const factory Message.codeUpdate({required String code}) = CodeUpdate;

  factory Message.fromJson(Map<String, Object?> json) =>
      _$MessageFromJson(json);
}
