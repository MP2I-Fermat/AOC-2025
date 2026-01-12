// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'protocol.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
Message _$MessageFromJson(
  Map<String, dynamic> json
) {
        switch (json['runtimeType']) {
                  case 'startWritingCode':
          return StartWritingCode.fromJson(
            json
          );
                case 'watch':
          return Watch.fromJson(
            json
          );
                case 'usersUpdate':
          return UsersUpdate.fromJson(
            json
          );
                case 'codeUpdate':
          return CodeUpdate.fromJson(
            json
          );
                case 'startEvaluation':
          return StartEvaluation.fromJson(
            json
          );
                case 'stopEvaluation':
          return StopEvaluation.fromJson(
            json
          );
                case 'inputLine':
          return InputLine.fromJson(
            json
          );
                case 'outputUpdate':
          return OutputUpdate.fromJson(
            json
          );
                case 'problemsUpdate':
          return ProblemsUpdate.fromJson(
            json
          );
                case 'submitSolution':
          return SubmitSolution.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'runtimeType',
  'Message',
  'Invalid union type "${json['runtimeType']}"!'
);
        }
      
}

/// @nodoc
mixin _$Message {



  /// Serializes this Message to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Message);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Message()';
}


}

/// @nodoc
class $MessageCopyWith<$Res>  {
$MessageCopyWith(Message _, $Res Function(Message) __);
}


/// Adds pattern-matching-related methods to [Message].
extension MessagePatterns on Message {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( StartWritingCode value)?  startWritingCode,TResult Function( Watch value)?  watch,TResult Function( UsersUpdate value)?  usersUpdate,TResult Function( CodeUpdate value)?  codeUpdate,TResult Function( StartEvaluation value)?  startEvaluation,TResult Function( StopEvaluation value)?  stopEvaluation,TResult Function( InputLine value)?  inputLine,TResult Function( OutputUpdate value)?  outputUpdate,TResult Function( ProblemsUpdate value)?  problemsUpdate,TResult Function( SubmitSolution value)?  submitSolution,required TResult orElse(),}){
final _that = this;
switch (_that) {
case StartWritingCode() when startWritingCode != null:
return startWritingCode(_that);case Watch() when watch != null:
return watch(_that);case UsersUpdate() when usersUpdate != null:
return usersUpdate(_that);case CodeUpdate() when codeUpdate != null:
return codeUpdate(_that);case StartEvaluation() when startEvaluation != null:
return startEvaluation(_that);case StopEvaluation() when stopEvaluation != null:
return stopEvaluation(_that);case InputLine() when inputLine != null:
return inputLine(_that);case OutputUpdate() when outputUpdate != null:
return outputUpdate(_that);case ProblemsUpdate() when problemsUpdate != null:
return problemsUpdate(_that);case SubmitSolution() when submitSolution != null:
return submitSolution(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( StartWritingCode value)  startWritingCode,required TResult Function( Watch value)  watch,required TResult Function( UsersUpdate value)  usersUpdate,required TResult Function( CodeUpdate value)  codeUpdate,required TResult Function( StartEvaluation value)  startEvaluation,required TResult Function( StopEvaluation value)  stopEvaluation,required TResult Function( InputLine value)  inputLine,required TResult Function( OutputUpdate value)  outputUpdate,required TResult Function( ProblemsUpdate value)  problemsUpdate,required TResult Function( SubmitSolution value)  submitSolution,}){
final _that = this;
switch (_that) {
case StartWritingCode():
return startWritingCode(_that);case Watch():
return watch(_that);case UsersUpdate():
return usersUpdate(_that);case CodeUpdate():
return codeUpdate(_that);case StartEvaluation():
return startEvaluation(_that);case StopEvaluation():
return stopEvaluation(_that);case InputLine():
return inputLine(_that);case OutputUpdate():
return outputUpdate(_that);case ProblemsUpdate():
return problemsUpdate(_that);case SubmitSolution():
return submitSolution(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( StartWritingCode value)?  startWritingCode,TResult? Function( Watch value)?  watch,TResult? Function( UsersUpdate value)?  usersUpdate,TResult? Function( CodeUpdate value)?  codeUpdate,TResult? Function( StartEvaluation value)?  startEvaluation,TResult? Function( StopEvaluation value)?  stopEvaluation,TResult? Function( InputLine value)?  inputLine,TResult? Function( OutputUpdate value)?  outputUpdate,TResult? Function( ProblemsUpdate value)?  problemsUpdate,TResult? Function( SubmitSolution value)?  submitSolution,}){
final _that = this;
switch (_that) {
case StartWritingCode() when startWritingCode != null:
return startWritingCode(_that);case Watch() when watch != null:
return watch(_that);case UsersUpdate() when usersUpdate != null:
return usersUpdate(_that);case CodeUpdate() when codeUpdate != null:
return codeUpdate(_that);case StartEvaluation() when startEvaluation != null:
return startEvaluation(_that);case StopEvaluation() when stopEvaluation != null:
return stopEvaluation(_that);case InputLine() when inputLine != null:
return inputLine(_that);case OutputUpdate() when outputUpdate != null:
return outputUpdate(_that);case ProblemsUpdate() when problemsUpdate != null:
return problemsUpdate(_that);case SubmitSolution() when submitSolution != null:
return submitSolution(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String? nick)?  startWritingCode,TResult Function( int id)?  watch,TResult Function( Map<int, UserInfo> users,  int yourId)?  usersUpdate,TResult Function( String code)?  codeUpdate,TResult Function( String code)?  startEvaluation,TResult Function()?  stopEvaluation,TResult Function( String line)?  inputLine,TResult Function( List<OutputLine> output,  bool isRunning,  bool isInputEnabled)?  outputUpdate,TResult Function( Map<String, ProblemInfo> problems)?  problemsUpdate,TResult Function( String problem,  String code)?  submitSolution,required TResult orElse(),}) {final _that = this;
switch (_that) {
case StartWritingCode() when startWritingCode != null:
return startWritingCode(_that.nick);case Watch() when watch != null:
return watch(_that.id);case UsersUpdate() when usersUpdate != null:
return usersUpdate(_that.users,_that.yourId);case CodeUpdate() when codeUpdate != null:
return codeUpdate(_that.code);case StartEvaluation() when startEvaluation != null:
return startEvaluation(_that.code);case StopEvaluation() when stopEvaluation != null:
return stopEvaluation();case InputLine() when inputLine != null:
return inputLine(_that.line);case OutputUpdate() when outputUpdate != null:
return outputUpdate(_that.output,_that.isRunning,_that.isInputEnabled);case ProblemsUpdate() when problemsUpdate != null:
return problemsUpdate(_that.problems);case SubmitSolution() when submitSolution != null:
return submitSolution(_that.problem,_that.code);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String? nick)  startWritingCode,required TResult Function( int id)  watch,required TResult Function( Map<int, UserInfo> users,  int yourId)  usersUpdate,required TResult Function( String code)  codeUpdate,required TResult Function( String code)  startEvaluation,required TResult Function()  stopEvaluation,required TResult Function( String line)  inputLine,required TResult Function( List<OutputLine> output,  bool isRunning,  bool isInputEnabled)  outputUpdate,required TResult Function( Map<String, ProblemInfo> problems)  problemsUpdate,required TResult Function( String problem,  String code)  submitSolution,}) {final _that = this;
switch (_that) {
case StartWritingCode():
return startWritingCode(_that.nick);case Watch():
return watch(_that.id);case UsersUpdate():
return usersUpdate(_that.users,_that.yourId);case CodeUpdate():
return codeUpdate(_that.code);case StartEvaluation():
return startEvaluation(_that.code);case StopEvaluation():
return stopEvaluation();case InputLine():
return inputLine(_that.line);case OutputUpdate():
return outputUpdate(_that.output,_that.isRunning,_that.isInputEnabled);case ProblemsUpdate():
return problemsUpdate(_that.problems);case SubmitSolution():
return submitSolution(_that.problem,_that.code);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String? nick)?  startWritingCode,TResult? Function( int id)?  watch,TResult? Function( Map<int, UserInfo> users,  int yourId)?  usersUpdate,TResult? Function( String code)?  codeUpdate,TResult? Function( String code)?  startEvaluation,TResult? Function()?  stopEvaluation,TResult? Function( String line)?  inputLine,TResult? Function( List<OutputLine> output,  bool isRunning,  bool isInputEnabled)?  outputUpdate,TResult? Function( Map<String, ProblemInfo> problems)?  problemsUpdate,TResult? Function( String problem,  String code)?  submitSolution,}) {final _that = this;
switch (_that) {
case StartWritingCode() when startWritingCode != null:
return startWritingCode(_that.nick);case Watch() when watch != null:
return watch(_that.id);case UsersUpdate() when usersUpdate != null:
return usersUpdate(_that.users,_that.yourId);case CodeUpdate() when codeUpdate != null:
return codeUpdate(_that.code);case StartEvaluation() when startEvaluation != null:
return startEvaluation(_that.code);case StopEvaluation() when stopEvaluation != null:
return stopEvaluation();case InputLine() when inputLine != null:
return inputLine(_that.line);case OutputUpdate() when outputUpdate != null:
return outputUpdate(_that.output,_that.isRunning,_that.isInputEnabled);case ProblemsUpdate() when problemsUpdate != null:
return problemsUpdate(_that.problems);case SubmitSolution() when submitSolution != null:
return submitSolution(_that.problem,_that.code);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class StartWritingCode implements Message {
  const StartWritingCode({required this.nick, final  String? $type}): $type = $type ?? 'startWritingCode';
  factory StartWritingCode.fromJson(Map<String, dynamic> json) => _$StartWritingCodeFromJson(json);

 final  String? nick;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StartWritingCodeCopyWith<StartWritingCode> get copyWith => _$StartWritingCodeCopyWithImpl<StartWritingCode>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StartWritingCodeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StartWritingCode&&(identical(other.nick, nick) || other.nick == nick));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,nick);

@override
String toString() {
  return 'Message.startWritingCode(nick: $nick)';
}


}

/// @nodoc
abstract mixin class $StartWritingCodeCopyWith<$Res> implements $MessageCopyWith<$Res> {
  factory $StartWritingCodeCopyWith(StartWritingCode value, $Res Function(StartWritingCode) _then) = _$StartWritingCodeCopyWithImpl;
@useResult
$Res call({
 String? nick
});




}
/// @nodoc
class _$StartWritingCodeCopyWithImpl<$Res>
    implements $StartWritingCodeCopyWith<$Res> {
  _$StartWritingCodeCopyWithImpl(this._self, this._then);

  final StartWritingCode _self;
  final $Res Function(StartWritingCode) _then;

/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? nick = freezed,}) {
  return _then(StartWritingCode(
nick: freezed == nick ? _self.nick : nick // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class Watch implements Message {
  const Watch({required this.id, final  String? $type}): $type = $type ?? 'watch';
  factory Watch.fromJson(Map<String, dynamic> json) => _$WatchFromJson(json);

 final  int id;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WatchCopyWith<Watch> get copyWith => _$WatchCopyWithImpl<Watch>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WatchToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Watch&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'Message.watch(id: $id)';
}


}

/// @nodoc
abstract mixin class $WatchCopyWith<$Res> implements $MessageCopyWith<$Res> {
  factory $WatchCopyWith(Watch value, $Res Function(Watch) _then) = _$WatchCopyWithImpl;
@useResult
$Res call({
 int id
});




}
/// @nodoc
class _$WatchCopyWithImpl<$Res>
    implements $WatchCopyWith<$Res> {
  _$WatchCopyWithImpl(this._self, this._then);

  final Watch _self;
  final $Res Function(Watch) _then;

/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(Watch(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
@JsonSerializable()

class UsersUpdate implements Message {
  const UsersUpdate({required final  Map<int, UserInfo> users, required this.yourId, final  String? $type}): _users = users,$type = $type ?? 'usersUpdate';
  factory UsersUpdate.fromJson(Map<String, dynamic> json) => _$UsersUpdateFromJson(json);

 final  Map<int, UserInfo> _users;
 Map<int, UserInfo> get users {
  if (_users is EqualUnmodifiableMapView) return _users;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_users);
}

 final  int yourId;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UsersUpdateCopyWith<UsersUpdate> get copyWith => _$UsersUpdateCopyWithImpl<UsersUpdate>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UsersUpdateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UsersUpdate&&const DeepCollectionEquality().equals(other._users, _users)&&(identical(other.yourId, yourId) || other.yourId == yourId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_users),yourId);

@override
String toString() {
  return 'Message.usersUpdate(users: $users, yourId: $yourId)';
}


}

/// @nodoc
abstract mixin class $UsersUpdateCopyWith<$Res> implements $MessageCopyWith<$Res> {
  factory $UsersUpdateCopyWith(UsersUpdate value, $Res Function(UsersUpdate) _then) = _$UsersUpdateCopyWithImpl;
@useResult
$Res call({
 Map<int, UserInfo> users, int yourId
});




}
/// @nodoc
class _$UsersUpdateCopyWithImpl<$Res>
    implements $UsersUpdateCopyWith<$Res> {
  _$UsersUpdateCopyWithImpl(this._self, this._then);

  final UsersUpdate _self;
  final $Res Function(UsersUpdate) _then;

/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? users = null,Object? yourId = null,}) {
  return _then(UsersUpdate(
users: null == users ? _self._users : users // ignore: cast_nullable_to_non_nullable
as Map<int, UserInfo>,yourId: null == yourId ? _self.yourId : yourId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
@JsonSerializable()

class CodeUpdate implements Message {
  const CodeUpdate({required this.code, final  String? $type}): $type = $type ?? 'codeUpdate';
  factory CodeUpdate.fromJson(Map<String, dynamic> json) => _$CodeUpdateFromJson(json);

 final  String code;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CodeUpdateCopyWith<CodeUpdate> get copyWith => _$CodeUpdateCopyWithImpl<CodeUpdate>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CodeUpdateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CodeUpdate&&(identical(other.code, code) || other.code == code));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code);

@override
String toString() {
  return 'Message.codeUpdate(code: $code)';
}


}

/// @nodoc
abstract mixin class $CodeUpdateCopyWith<$Res> implements $MessageCopyWith<$Res> {
  factory $CodeUpdateCopyWith(CodeUpdate value, $Res Function(CodeUpdate) _then) = _$CodeUpdateCopyWithImpl;
@useResult
$Res call({
 String code
});




}
/// @nodoc
class _$CodeUpdateCopyWithImpl<$Res>
    implements $CodeUpdateCopyWith<$Res> {
  _$CodeUpdateCopyWithImpl(this._self, this._then);

  final CodeUpdate _self;
  final $Res Function(CodeUpdate) _then;

/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? code = null,}) {
  return _then(CodeUpdate(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class StartEvaluation implements Message {
  const StartEvaluation({required this.code, final  String? $type}): $type = $type ?? 'startEvaluation';
  factory StartEvaluation.fromJson(Map<String, dynamic> json) => _$StartEvaluationFromJson(json);

 final  String code;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StartEvaluationCopyWith<StartEvaluation> get copyWith => _$StartEvaluationCopyWithImpl<StartEvaluation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StartEvaluationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StartEvaluation&&(identical(other.code, code) || other.code == code));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code);

@override
String toString() {
  return 'Message.startEvaluation(code: $code)';
}


}

/// @nodoc
abstract mixin class $StartEvaluationCopyWith<$Res> implements $MessageCopyWith<$Res> {
  factory $StartEvaluationCopyWith(StartEvaluation value, $Res Function(StartEvaluation) _then) = _$StartEvaluationCopyWithImpl;
@useResult
$Res call({
 String code
});




}
/// @nodoc
class _$StartEvaluationCopyWithImpl<$Res>
    implements $StartEvaluationCopyWith<$Res> {
  _$StartEvaluationCopyWithImpl(this._self, this._then);

  final StartEvaluation _self;
  final $Res Function(StartEvaluation) _then;

/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? code = null,}) {
  return _then(StartEvaluation(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class StopEvaluation implements Message {
  const StopEvaluation({final  String? $type}): $type = $type ?? 'stopEvaluation';
  factory StopEvaluation.fromJson(Map<String, dynamic> json) => _$StopEvaluationFromJson(json);



@JsonKey(name: 'runtimeType')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$StopEvaluationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StopEvaluation);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Message.stopEvaluation()';
}


}




/// @nodoc
@JsonSerializable()

class InputLine implements Message {
  const InputLine({required this.line, final  String? $type}): $type = $type ?? 'inputLine';
  factory InputLine.fromJson(Map<String, dynamic> json) => _$InputLineFromJson(json);

 final  String line;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InputLineCopyWith<InputLine> get copyWith => _$InputLineCopyWithImpl<InputLine>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InputLineToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InputLine&&(identical(other.line, line) || other.line == line));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,line);

@override
String toString() {
  return 'Message.inputLine(line: $line)';
}


}

/// @nodoc
abstract mixin class $InputLineCopyWith<$Res> implements $MessageCopyWith<$Res> {
  factory $InputLineCopyWith(InputLine value, $Res Function(InputLine) _then) = _$InputLineCopyWithImpl;
@useResult
$Res call({
 String line
});




}
/// @nodoc
class _$InputLineCopyWithImpl<$Res>
    implements $InputLineCopyWith<$Res> {
  _$InputLineCopyWithImpl(this._self, this._then);

  final InputLine _self;
  final $Res Function(InputLine) _then;

/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? line = null,}) {
  return _then(InputLine(
line: null == line ? _self.line : line // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class OutputUpdate implements Message {
  const OutputUpdate({required final  List<OutputLine> output, required this.isRunning, required this.isInputEnabled, final  String? $type}): _output = output,$type = $type ?? 'outputUpdate';
  factory OutputUpdate.fromJson(Map<String, dynamic> json) => _$OutputUpdateFromJson(json);

 final  List<OutputLine> _output;
 List<OutputLine> get output {
  if (_output is EqualUnmodifiableListView) return _output;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_output);
}

 final  bool isRunning;
 final  bool isInputEnabled;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OutputUpdateCopyWith<OutputUpdate> get copyWith => _$OutputUpdateCopyWithImpl<OutputUpdate>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OutputUpdateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OutputUpdate&&const DeepCollectionEquality().equals(other._output, _output)&&(identical(other.isRunning, isRunning) || other.isRunning == isRunning)&&(identical(other.isInputEnabled, isInputEnabled) || other.isInputEnabled == isInputEnabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_output),isRunning,isInputEnabled);

@override
String toString() {
  return 'Message.outputUpdate(output: $output, isRunning: $isRunning, isInputEnabled: $isInputEnabled)';
}


}

/// @nodoc
abstract mixin class $OutputUpdateCopyWith<$Res> implements $MessageCopyWith<$Res> {
  factory $OutputUpdateCopyWith(OutputUpdate value, $Res Function(OutputUpdate) _then) = _$OutputUpdateCopyWithImpl;
@useResult
$Res call({
 List<OutputLine> output, bool isRunning, bool isInputEnabled
});




}
/// @nodoc
class _$OutputUpdateCopyWithImpl<$Res>
    implements $OutputUpdateCopyWith<$Res> {
  _$OutputUpdateCopyWithImpl(this._self, this._then);

  final OutputUpdate _self;
  final $Res Function(OutputUpdate) _then;

/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? output = null,Object? isRunning = null,Object? isInputEnabled = null,}) {
  return _then(OutputUpdate(
output: null == output ? _self._output : output // ignore: cast_nullable_to_non_nullable
as List<OutputLine>,isRunning: null == isRunning ? _self.isRunning : isRunning // ignore: cast_nullable_to_non_nullable
as bool,isInputEnabled: null == isInputEnabled ? _self.isInputEnabled : isInputEnabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
@JsonSerializable()

class ProblemsUpdate implements Message {
  const ProblemsUpdate({required final  Map<String, ProblemInfo> problems, final  String? $type}): _problems = problems,$type = $type ?? 'problemsUpdate';
  factory ProblemsUpdate.fromJson(Map<String, dynamic> json) => _$ProblemsUpdateFromJson(json);

 final  Map<String, ProblemInfo> _problems;
 Map<String, ProblemInfo> get problems {
  if (_problems is EqualUnmodifiableMapView) return _problems;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_problems);
}


@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProblemsUpdateCopyWith<ProblemsUpdate> get copyWith => _$ProblemsUpdateCopyWithImpl<ProblemsUpdate>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProblemsUpdateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProblemsUpdate&&const DeepCollectionEquality().equals(other._problems, _problems));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_problems));

@override
String toString() {
  return 'Message.problemsUpdate(problems: $problems)';
}


}

/// @nodoc
abstract mixin class $ProblemsUpdateCopyWith<$Res> implements $MessageCopyWith<$Res> {
  factory $ProblemsUpdateCopyWith(ProblemsUpdate value, $Res Function(ProblemsUpdate) _then) = _$ProblemsUpdateCopyWithImpl;
@useResult
$Res call({
 Map<String, ProblemInfo> problems
});




}
/// @nodoc
class _$ProblemsUpdateCopyWithImpl<$Res>
    implements $ProblemsUpdateCopyWith<$Res> {
  _$ProblemsUpdateCopyWithImpl(this._self, this._then);

  final ProblemsUpdate _self;
  final $Res Function(ProblemsUpdate) _then;

/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? problems = null,}) {
  return _then(ProblemsUpdate(
problems: null == problems ? _self._problems : problems // ignore: cast_nullable_to_non_nullable
as Map<String, ProblemInfo>,
  ));
}


}

/// @nodoc
@JsonSerializable()

class SubmitSolution implements Message {
  const SubmitSolution({required this.problem, required this.code, final  String? $type}): $type = $type ?? 'submitSolution';
  factory SubmitSolution.fromJson(Map<String, dynamic> json) => _$SubmitSolutionFromJson(json);

 final  String problem;
 final  String code;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubmitSolutionCopyWith<SubmitSolution> get copyWith => _$SubmitSolutionCopyWithImpl<SubmitSolution>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SubmitSolutionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubmitSolution&&(identical(other.problem, problem) || other.problem == problem)&&(identical(other.code, code) || other.code == code));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,problem,code);

@override
String toString() {
  return 'Message.submitSolution(problem: $problem, code: $code)';
}


}

/// @nodoc
abstract mixin class $SubmitSolutionCopyWith<$Res> implements $MessageCopyWith<$Res> {
  factory $SubmitSolutionCopyWith(SubmitSolution value, $Res Function(SubmitSolution) _then) = _$SubmitSolutionCopyWithImpl;
@useResult
$Res call({
 String problem, String code
});




}
/// @nodoc
class _$SubmitSolutionCopyWithImpl<$Res>
    implements $SubmitSolutionCopyWith<$Res> {
  _$SubmitSolutionCopyWithImpl(this._self, this._then);

  final SubmitSolution _self;
  final $Res Function(SubmitSolution) _then;

/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? problem = null,Object? code = null,}) {
  return _then(SubmitSolution(
problem: null == problem ? _self.problem : problem // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ProblemInfo {

 bool get unlocked; List<TestStatus> get testCaseStatus;
/// Create a copy of ProblemInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProblemInfoCopyWith<ProblemInfo> get copyWith => _$ProblemInfoCopyWithImpl<ProblemInfo>(this as ProblemInfo, _$identity);

  /// Serializes this ProblemInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProblemInfo&&(identical(other.unlocked, unlocked) || other.unlocked == unlocked)&&const DeepCollectionEquality().equals(other.testCaseStatus, testCaseStatus));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,unlocked,const DeepCollectionEquality().hash(testCaseStatus));

@override
String toString() {
  return 'ProblemInfo(unlocked: $unlocked, testCaseStatus: $testCaseStatus)';
}


}

/// @nodoc
abstract mixin class $ProblemInfoCopyWith<$Res>  {
  factory $ProblemInfoCopyWith(ProblemInfo value, $Res Function(ProblemInfo) _then) = _$ProblemInfoCopyWithImpl;
@useResult
$Res call({
 bool unlocked, List<TestStatus> testCaseStatus
});




}
/// @nodoc
class _$ProblemInfoCopyWithImpl<$Res>
    implements $ProblemInfoCopyWith<$Res> {
  _$ProblemInfoCopyWithImpl(this._self, this._then);

  final ProblemInfo _self;
  final $Res Function(ProblemInfo) _then;

/// Create a copy of ProblemInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? unlocked = null,Object? testCaseStatus = null,}) {
  return _then(_self.copyWith(
unlocked: null == unlocked ? _self.unlocked : unlocked // ignore: cast_nullable_to_non_nullable
as bool,testCaseStatus: null == testCaseStatus ? _self.testCaseStatus : testCaseStatus // ignore: cast_nullable_to_non_nullable
as List<TestStatus>,
  ));
}

}


/// Adds pattern-matching-related methods to [ProblemInfo].
extension ProblemInfoPatterns on ProblemInfo {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProblemInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProblemInfo() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProblemInfo value)  $default,){
final _that = this;
switch (_that) {
case _ProblemInfo():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProblemInfo value)?  $default,){
final _that = this;
switch (_that) {
case _ProblemInfo() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool unlocked,  List<TestStatus> testCaseStatus)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProblemInfo() when $default != null:
return $default(_that.unlocked,_that.testCaseStatus);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool unlocked,  List<TestStatus> testCaseStatus)  $default,) {final _that = this;
switch (_that) {
case _ProblemInfo():
return $default(_that.unlocked,_that.testCaseStatus);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool unlocked,  List<TestStatus> testCaseStatus)?  $default,) {final _that = this;
switch (_that) {
case _ProblemInfo() when $default != null:
return $default(_that.unlocked,_that.testCaseStatus);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProblemInfo implements ProblemInfo {
  const _ProblemInfo({required this.unlocked, required final  List<TestStatus> testCaseStatus}): _testCaseStatus = testCaseStatus;
  factory _ProblemInfo.fromJson(Map<String, dynamic> json) => _$ProblemInfoFromJson(json);

@override final  bool unlocked;
 final  List<TestStatus> _testCaseStatus;
@override List<TestStatus> get testCaseStatus {
  if (_testCaseStatus is EqualUnmodifiableListView) return _testCaseStatus;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_testCaseStatus);
}


/// Create a copy of ProblemInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProblemInfoCopyWith<_ProblemInfo> get copyWith => __$ProblemInfoCopyWithImpl<_ProblemInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProblemInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProblemInfo&&(identical(other.unlocked, unlocked) || other.unlocked == unlocked)&&const DeepCollectionEquality().equals(other._testCaseStatus, _testCaseStatus));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,unlocked,const DeepCollectionEquality().hash(_testCaseStatus));

@override
String toString() {
  return 'ProblemInfo(unlocked: $unlocked, testCaseStatus: $testCaseStatus)';
}


}

/// @nodoc
abstract mixin class _$ProblemInfoCopyWith<$Res> implements $ProblemInfoCopyWith<$Res> {
  factory _$ProblemInfoCopyWith(_ProblemInfo value, $Res Function(_ProblemInfo) _then) = __$ProblemInfoCopyWithImpl;
@override @useResult
$Res call({
 bool unlocked, List<TestStatus> testCaseStatus
});




}
/// @nodoc
class __$ProblemInfoCopyWithImpl<$Res>
    implements _$ProblemInfoCopyWith<$Res> {
  __$ProblemInfoCopyWithImpl(this._self, this._then);

  final _ProblemInfo _self;
  final $Res Function(_ProblemInfo) _then;

/// Create a copy of ProblemInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? unlocked = null,Object? testCaseStatus = null,}) {
  return _then(_ProblemInfo(
unlocked: null == unlocked ? _self.unlocked : unlocked // ignore: cast_nullable_to_non_nullable
as bool,testCaseStatus: null == testCaseStatus ? _self._testCaseStatus : testCaseStatus // ignore: cast_nullable_to_non_nullable
as List<TestStatus>,
  ));
}


}


/// @nodoc
mixin _$UserInfo {

 String get nick; int get numViewers; int get problemNumber; TestStatus get displayStatus;
/// Create a copy of UserInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserInfoCopyWith<UserInfo> get copyWith => _$UserInfoCopyWithImpl<UserInfo>(this as UserInfo, _$identity);

  /// Serializes this UserInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserInfo&&(identical(other.nick, nick) || other.nick == nick)&&(identical(other.numViewers, numViewers) || other.numViewers == numViewers)&&(identical(other.problemNumber, problemNumber) || other.problemNumber == problemNumber)&&(identical(other.displayStatus, displayStatus) || other.displayStatus == displayStatus));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,nick,numViewers,problemNumber,displayStatus);

@override
String toString() {
  return 'UserInfo(nick: $nick, numViewers: $numViewers, problemNumber: $problemNumber, displayStatus: $displayStatus)';
}


}

/// @nodoc
abstract mixin class $UserInfoCopyWith<$Res>  {
  factory $UserInfoCopyWith(UserInfo value, $Res Function(UserInfo) _then) = _$UserInfoCopyWithImpl;
@useResult
$Res call({
 String nick, int numViewers, int problemNumber, TestStatus displayStatus
});




}
/// @nodoc
class _$UserInfoCopyWithImpl<$Res>
    implements $UserInfoCopyWith<$Res> {
  _$UserInfoCopyWithImpl(this._self, this._then);

  final UserInfo _self;
  final $Res Function(UserInfo) _then;

/// Create a copy of UserInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? nick = null,Object? numViewers = null,Object? problemNumber = null,Object? displayStatus = null,}) {
  return _then(_self.copyWith(
nick: null == nick ? _self.nick : nick // ignore: cast_nullable_to_non_nullable
as String,numViewers: null == numViewers ? _self.numViewers : numViewers // ignore: cast_nullable_to_non_nullable
as int,problemNumber: null == problemNumber ? _self.problemNumber : problemNumber // ignore: cast_nullable_to_non_nullable
as int,displayStatus: null == displayStatus ? _self.displayStatus : displayStatus // ignore: cast_nullable_to_non_nullable
as TestStatus,
  ));
}

}


/// Adds pattern-matching-related methods to [UserInfo].
extension UserInfoPatterns on UserInfo {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserInfo() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserInfo value)  $default,){
final _that = this;
switch (_that) {
case _UserInfo():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserInfo value)?  $default,){
final _that = this;
switch (_that) {
case _UserInfo() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String nick,  int numViewers,  int problemNumber,  TestStatus displayStatus)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserInfo() when $default != null:
return $default(_that.nick,_that.numViewers,_that.problemNumber,_that.displayStatus);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String nick,  int numViewers,  int problemNumber,  TestStatus displayStatus)  $default,) {final _that = this;
switch (_that) {
case _UserInfo():
return $default(_that.nick,_that.numViewers,_that.problemNumber,_that.displayStatus);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String nick,  int numViewers,  int problemNumber,  TestStatus displayStatus)?  $default,) {final _that = this;
switch (_that) {
case _UserInfo() when $default != null:
return $default(_that.nick,_that.numViewers,_that.problemNumber,_that.displayStatus);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserInfo implements UserInfo {
  const _UserInfo({required this.nick, required this.numViewers, required this.problemNumber, required this.displayStatus});
  factory _UserInfo.fromJson(Map<String, dynamic> json) => _$UserInfoFromJson(json);

@override final  String nick;
@override final  int numViewers;
@override final  int problemNumber;
@override final  TestStatus displayStatus;

/// Create a copy of UserInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserInfoCopyWith<_UserInfo> get copyWith => __$UserInfoCopyWithImpl<_UserInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserInfo&&(identical(other.nick, nick) || other.nick == nick)&&(identical(other.numViewers, numViewers) || other.numViewers == numViewers)&&(identical(other.problemNumber, problemNumber) || other.problemNumber == problemNumber)&&(identical(other.displayStatus, displayStatus) || other.displayStatus == displayStatus));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,nick,numViewers,problemNumber,displayStatus);

@override
String toString() {
  return 'UserInfo(nick: $nick, numViewers: $numViewers, problemNumber: $problemNumber, displayStatus: $displayStatus)';
}


}

/// @nodoc
abstract mixin class _$UserInfoCopyWith<$Res> implements $UserInfoCopyWith<$Res> {
  factory _$UserInfoCopyWith(_UserInfo value, $Res Function(_UserInfo) _then) = __$UserInfoCopyWithImpl;
@override @useResult
$Res call({
 String nick, int numViewers, int problemNumber, TestStatus displayStatus
});




}
/// @nodoc
class __$UserInfoCopyWithImpl<$Res>
    implements _$UserInfoCopyWith<$Res> {
  __$UserInfoCopyWithImpl(this._self, this._then);

  final _UserInfo _self;
  final $Res Function(_UserInfo) _then;

/// Create a copy of UserInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? nick = null,Object? numViewers = null,Object? problemNumber = null,Object? displayStatus = null,}) {
  return _then(_UserInfo(
nick: null == nick ? _self.nick : nick // ignore: cast_nullable_to_non_nullable
as String,numViewers: null == numViewers ? _self.numViewers : numViewers // ignore: cast_nullable_to_non_nullable
as int,problemNumber: null == problemNumber ? _self.problemNumber : problemNumber // ignore: cast_nullable_to_non_nullable
as int,displayStatus: null == displayStatus ? _self.displayStatus : displayStatus // ignore: cast_nullable_to_non_nullable
as TestStatus,
  ));
}


}


/// @nodoc
mixin _$OutputLine {

 OutputStream get stream; String get line;
/// Create a copy of OutputLine
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OutputLineCopyWith<OutputLine> get copyWith => _$OutputLineCopyWithImpl<OutputLine>(this as OutputLine, _$identity);

  /// Serializes this OutputLine to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OutputLine&&(identical(other.stream, stream) || other.stream == stream)&&(identical(other.line, line) || other.line == line));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,stream,line);

@override
String toString() {
  return 'OutputLine(stream: $stream, line: $line)';
}


}

/// @nodoc
abstract mixin class $OutputLineCopyWith<$Res>  {
  factory $OutputLineCopyWith(OutputLine value, $Res Function(OutputLine) _then) = _$OutputLineCopyWithImpl;
@useResult
$Res call({
 OutputStream stream, String line
});




}
/// @nodoc
class _$OutputLineCopyWithImpl<$Res>
    implements $OutputLineCopyWith<$Res> {
  _$OutputLineCopyWithImpl(this._self, this._then);

  final OutputLine _self;
  final $Res Function(OutputLine) _then;

/// Create a copy of OutputLine
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? stream = null,Object? line = null,}) {
  return _then(_self.copyWith(
stream: null == stream ? _self.stream : stream // ignore: cast_nullable_to_non_nullable
as OutputStream,line: null == line ? _self.line : line // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [OutputLine].
extension OutputLinePatterns on OutputLine {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OutputLine value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OutputLine() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OutputLine value)  $default,){
final _that = this;
switch (_that) {
case _OutputLine():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OutputLine value)?  $default,){
final _that = this;
switch (_that) {
case _OutputLine() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( OutputStream stream,  String line)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OutputLine() when $default != null:
return $default(_that.stream,_that.line);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( OutputStream stream,  String line)  $default,) {final _that = this;
switch (_that) {
case _OutputLine():
return $default(_that.stream,_that.line);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( OutputStream stream,  String line)?  $default,) {final _that = this;
switch (_that) {
case _OutputLine() when $default != null:
return $default(_that.stream,_that.line);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OutputLine implements OutputLine {
  const _OutputLine({required this.stream, required this.line});
  factory _OutputLine.fromJson(Map<String, dynamic> json) => _$OutputLineFromJson(json);

@override final  OutputStream stream;
@override final  String line;

/// Create a copy of OutputLine
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OutputLineCopyWith<_OutputLine> get copyWith => __$OutputLineCopyWithImpl<_OutputLine>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OutputLineToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OutputLine&&(identical(other.stream, stream) || other.stream == stream)&&(identical(other.line, line) || other.line == line));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,stream,line);

@override
String toString() {
  return 'OutputLine(stream: $stream, line: $line)';
}


}

/// @nodoc
abstract mixin class _$OutputLineCopyWith<$Res> implements $OutputLineCopyWith<$Res> {
  factory _$OutputLineCopyWith(_OutputLine value, $Res Function(_OutputLine) _then) = __$OutputLineCopyWithImpl;
@override @useResult
$Res call({
 OutputStream stream, String line
});




}
/// @nodoc
class __$OutputLineCopyWithImpl<$Res>
    implements _$OutputLineCopyWith<$Res> {
  __$OutputLineCopyWithImpl(this._self, this._then);

  final _OutputLine _self;
  final $Res Function(_OutputLine) _then;

/// Create a copy of OutputLine
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? stream = null,Object? line = null,}) {
  return _then(_OutputLine(
stream: null == stream ? _self.stream : stream // ignore: cast_nullable_to_non_nullable
as OutputStream,line: null == line ? _self.line : line // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
