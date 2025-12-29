import 'package:freezed_annotation/freezed_annotation.dart';

part 'protocol.g.dart';
part 'protocol.freezed.dart';

@freezed
sealed class Message with _$Message {
  const factory Message.startWritingCode({required String? nick}) =
      StartWritingCode;
  const factory Message.watch({required int id}) = Watch;
  const factory Message.usersUpdate({
    required Map<int, UserInfo> users,
    required int yourId,
  }) = UsersUpdate;
  const factory Message.codeUpdate({required String code}) = CodeUpdate;
  const factory Message.startEvaluation({required String code}) =
      StartEvaluation;
  const factory Message.stopEvaluation() = StopEvaluation;
  const factory Message.inputLine({required String line}) = InputLine;
  const factory Message.outputUpdate({
    required List<OutputLine> output,
    required bool isRunning,
    required bool isInputEnabled,
  }) = OutputUpdate;
  const factory Message.problemsUpdate({
    required Map<String, ProblemInfo> problems,
  }) = ProblemsUpdate;
  const factory Message.submitSolution({
    required String problem,
    required String code,
  }) = SubmitSolution;

  factory Message.fromJson(Map<String, Object?> json) =>
      _$MessageFromJson(json);
}

enum TestStatus { pending, running, success, failed }

@freezed
sealed class ProblemInfo with _$ProblemInfo {
  const factory ProblemInfo({
    required bool unlocked,
    required List<TestStatus> testCaseStatus,
  }) = _ProblemInfo;

  factory ProblemInfo.fromJson(Map<String, Object?> json) =>
      _$ProblemInfoFromJson(json);
}

@freezed
sealed class UserInfo with _$UserInfo {
  const factory UserInfo({required String nick, required int numViewers}) =
      _UserInfo;

  factory UserInfo.fromJson(Map<String, Object?> json) =>
      _$UserInfoFromJson(json);
}

enum OutputStream { stdout, stdin, stderr }

@freezed
sealed class OutputLine with _$OutputLine {
  const factory OutputLine({
    required OutputStream stream,
    required String line,
  }) = _OutputLine;

  factory OutputLine.fromJson(Map<String, Object?> json) =>
      _$OutputLineFromJson(json);
}
