// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'protocol.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StartWritingCode _$StartWritingCodeFromJson(Map<String, dynamic> json) =>
    StartWritingCode(
      nick: json['nick'] as String?,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$StartWritingCodeToJson(StartWritingCode instance) =>
    <String, dynamic>{'nick': instance.nick, 'runtimeType': instance.$type};

Watch _$WatchFromJson(Map<String, dynamic> json) => Watch(
  id: (json['id'] as num).toInt(),
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$WatchToJson(Watch instance) => <String, dynamic>{
  'id': instance.id,
  'runtimeType': instance.$type,
};

UsersUpdate _$UsersUpdateFromJson(Map<String, dynamic> json) => UsersUpdate(
  users: (json['users'] as Map<String, dynamic>).map(
    (k, e) =>
        MapEntry(int.parse(k), UserInfo.fromJson(e as Map<String, dynamic>)),
  ),
  yourId: (json['yourId'] as num).toInt(),
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$UsersUpdateToJson(UsersUpdate instance) =>
    <String, dynamic>{
      'users': instance.users.map((k, e) => MapEntry(k.toString(), e)),
      'yourId': instance.yourId,
      'runtimeType': instance.$type,
    };

CodeUpdate _$CodeUpdateFromJson(Map<String, dynamic> json) => CodeUpdate(
  code: json['code'] as String,
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$CodeUpdateToJson(CodeUpdate instance) =>
    <String, dynamic>{'code': instance.code, 'runtimeType': instance.$type};

StartEvaluation _$StartEvaluationFromJson(Map<String, dynamic> json) =>
    StartEvaluation(
      code: json['code'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$StartEvaluationToJson(StartEvaluation instance) =>
    <String, dynamic>{'code': instance.code, 'runtimeType': instance.$type};

StopEvaluation _$StopEvaluationFromJson(Map<String, dynamic> json) =>
    StopEvaluation($type: json['runtimeType'] as String?);

Map<String, dynamic> _$StopEvaluationToJson(StopEvaluation instance) =>
    <String, dynamic>{'runtimeType': instance.$type};

InputLine _$InputLineFromJson(Map<String, dynamic> json) => InputLine(
  line: json['line'] as String,
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$InputLineToJson(InputLine instance) => <String, dynamic>{
  'line': instance.line,
  'runtimeType': instance.$type,
};

OutputUpdate _$OutputUpdateFromJson(Map<String, dynamic> json) => OutputUpdate(
  output: (json['output'] as List<dynamic>)
      .map((e) => OutputLine.fromJson(e as Map<String, dynamic>))
      .toList(),
  isRunning: json['isRunning'] as bool,
  isInputEnabled: json['isInputEnabled'] as bool,
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$OutputUpdateToJson(OutputUpdate instance) =>
    <String, dynamic>{
      'output': instance.output,
      'isRunning': instance.isRunning,
      'isInputEnabled': instance.isInputEnabled,
      'runtimeType': instance.$type,
    };

ProblemsUpdate _$ProblemsUpdateFromJson(Map<String, dynamic> json) =>
    ProblemsUpdate(
      problems: (json['problems'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, ProblemInfo.fromJson(e as Map<String, dynamic>)),
      ),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$ProblemsUpdateToJson(ProblemsUpdate instance) =>
    <String, dynamic>{
      'problems': instance.problems,
      'runtimeType': instance.$type,
    };

SubmitSolution _$SubmitSolutionFromJson(Map<String, dynamic> json) =>
    SubmitSolution(
      problem: json['problem'] as String,
      code: json['code'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$SubmitSolutionToJson(SubmitSolution instance) =>
    <String, dynamic>{
      'problem': instance.problem,
      'code': instance.code,
      'runtimeType': instance.$type,
    };

_ProblemInfo _$ProblemInfoFromJson(Map<String, dynamic> json) => _ProblemInfo(
  unlocked: json['unlocked'] as bool,
  testCaseStatus: (json['testCaseStatus'] as List<dynamic>)
      .map((e) => $enumDecode(_$TestStatusEnumMap, e))
      .toList(),
);

Map<String, dynamic> _$ProblemInfoToJson(_ProblemInfo instance) =>
    <String, dynamic>{
      'unlocked': instance.unlocked,
      'testCaseStatus': instance.testCaseStatus
          .map((e) => _$TestStatusEnumMap[e]!)
          .toList(),
    };

const _$TestStatusEnumMap = {
  TestStatus.pending: 'pending',
  TestStatus.running: 'running',
  TestStatus.success: 'success',
  TestStatus.failed: 'failed',
};

_UserInfo _$UserInfoFromJson(Map<String, dynamic> json) => _UserInfo(
  nick: json['nick'] as String,
  numViewers: (json['numViewers'] as num).toInt(),
  problemNumber: (json['problemNumber'] as num).toInt(),
  displayStatus: $enumDecode(_$TestStatusEnumMap, json['displayStatus']),
);

Map<String, dynamic> _$UserInfoToJson(_UserInfo instance) => <String, dynamic>{
  'nick': instance.nick,
  'numViewers': instance.numViewers,
  'problemNumber': instance.problemNumber,
  'displayStatus': _$TestStatusEnumMap[instance.displayStatus]!,
};

_OutputLine _$OutputLineFromJson(Map<String, dynamic> json) => _OutputLine(
  stream: $enumDecode(_$OutputStreamEnumMap, json['stream']),
  line: json['line'] as String,
);

Map<String, dynamic> _$OutputLineToJson(_OutputLine instance) =>
    <String, dynamic>{
      'stream': _$OutputStreamEnumMap[instance.stream]!,
      'line': instance.line,
    };

const _$OutputStreamEnumMap = {
  OutputStream.stdout: 'stdout',
  OutputStream.stdin: 'stdin',
  OutputStream.stderr: 'stderr',
};
