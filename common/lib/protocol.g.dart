// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'protocol.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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
  output: (json['output'] as List<dynamic>?)
      ?.map((e) => OutputLine.fromJson(e as Map<String, dynamic>))
      .toList(),
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$OutputUpdateToJson(OutputUpdate instance) =>
    <String, dynamic>{'output': instance.output, 'runtimeType': instance.$type};

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
