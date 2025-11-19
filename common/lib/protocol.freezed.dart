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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( StartWritingCode value)?  startWritingCode,TResult Function( Watch value)?  watch,TResult Function( UsersUpdate value)?  usersUpdate,TResult Function( CodeUpdate value)?  codeUpdate,TResult Function( StartEvaluation value)?  startEvaluation,TResult Function( StopEvaluation value)?  stopEvaluation,TResult Function( InputLine value)?  inputLine,TResult Function( OutputUpdate value)?  outputUpdate,required TResult orElse(),}){
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
return outputUpdate(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( StartWritingCode value)  startWritingCode,required TResult Function( Watch value)  watch,required TResult Function( UsersUpdate value)  usersUpdate,required TResult Function( CodeUpdate value)  codeUpdate,required TResult Function( StartEvaluation value)  startEvaluation,required TResult Function( StopEvaluation value)  stopEvaluation,required TResult Function( InputLine value)  inputLine,required TResult Function( OutputUpdate value)  outputUpdate,}){
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
return outputUpdate(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( StartWritingCode value)?  startWritingCode,TResult? Function( Watch value)?  watch,TResult? Function( UsersUpdate value)?  usersUpdate,TResult? Function( CodeUpdate value)?  codeUpdate,TResult? Function( StartEvaluation value)?  startEvaluation,TResult? Function( StopEvaluation value)?  stopEvaluation,TResult? Function( InputLine value)?  inputLine,TResult? Function( OutputUpdate value)?  outputUpdate,}){
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
return outputUpdate(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String nick)?  startWritingCode,TResult Function( int id)?  watch,TResult Function( Map<int, String> users,  int yourId)?  usersUpdate,TResult Function( String code)?  codeUpdate,TResult Function( String code)?  startEvaluation,TResult Function()?  stopEvaluation,TResult Function( String line)?  inputLine,TResult Function( List<OutputLine> output,  bool isRunning)?  outputUpdate,required TResult orElse(),}) {final _that = this;
switch (_that) {
case StartWritingCode() when startWritingCode != null:
return startWritingCode(_that.nick);case Watch() when watch != null:
return watch(_that.id);case UsersUpdate() when usersUpdate != null:
return usersUpdate(_that.users,_that.yourId);case CodeUpdate() when codeUpdate != null:
return codeUpdate(_that.code);case StartEvaluation() when startEvaluation != null:
return startEvaluation(_that.code);case StopEvaluation() when stopEvaluation != null:
return stopEvaluation();case InputLine() when inputLine != null:
return inputLine(_that.line);case OutputUpdate() when outputUpdate != null:
return outputUpdate(_that.output,_that.isRunning);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String nick)  startWritingCode,required TResult Function( int id)  watch,required TResult Function( Map<int, String> users,  int yourId)  usersUpdate,required TResult Function( String code)  codeUpdate,required TResult Function( String code)  startEvaluation,required TResult Function()  stopEvaluation,required TResult Function( String line)  inputLine,required TResult Function( List<OutputLine> output,  bool isRunning)  outputUpdate,}) {final _that = this;
switch (_that) {
case StartWritingCode():
return startWritingCode(_that.nick);case Watch():
return watch(_that.id);case UsersUpdate():
return usersUpdate(_that.users,_that.yourId);case CodeUpdate():
return codeUpdate(_that.code);case StartEvaluation():
return startEvaluation(_that.code);case StopEvaluation():
return stopEvaluation();case InputLine():
return inputLine(_that.line);case OutputUpdate():
return outputUpdate(_that.output,_that.isRunning);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String nick)?  startWritingCode,TResult? Function( int id)?  watch,TResult? Function( Map<int, String> users,  int yourId)?  usersUpdate,TResult? Function( String code)?  codeUpdate,TResult? Function( String code)?  startEvaluation,TResult? Function()?  stopEvaluation,TResult? Function( String line)?  inputLine,TResult? Function( List<OutputLine> output,  bool isRunning)?  outputUpdate,}) {final _that = this;
switch (_that) {
case StartWritingCode() when startWritingCode != null:
return startWritingCode(_that.nick);case Watch() when watch != null:
return watch(_that.id);case UsersUpdate() when usersUpdate != null:
return usersUpdate(_that.users,_that.yourId);case CodeUpdate() when codeUpdate != null:
return codeUpdate(_that.code);case StartEvaluation() when startEvaluation != null:
return startEvaluation(_that.code);case StopEvaluation() when stopEvaluation != null:
return stopEvaluation();case InputLine() when inputLine != null:
return inputLine(_that.line);case OutputUpdate() when outputUpdate != null:
return outputUpdate(_that.output,_that.isRunning);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class StartWritingCode implements Message {
  const StartWritingCode({required this.nick, final  String? $type}): $type = $type ?? 'startWritingCode';
  factory StartWritingCode.fromJson(Map<String, dynamic> json) => _$StartWritingCodeFromJson(json);

 final  String nick;

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
 String nick
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
@pragma('vm:prefer-inline') $Res call({Object? nick = null,}) {
  return _then(StartWritingCode(
nick: null == nick ? _self.nick : nick // ignore: cast_nullable_to_non_nullable
as String,
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
  const UsersUpdate({required final  Map<int, String> users, required this.yourId, final  String? $type}): _users = users,$type = $type ?? 'usersUpdate';
  factory UsersUpdate.fromJson(Map<String, dynamic> json) => _$UsersUpdateFromJson(json);

 final  Map<int, String> _users;
 Map<int, String> get users {
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
 Map<int, String> users, int yourId
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
as Map<int, String>,yourId: null == yourId ? _self.yourId : yourId // ignore: cast_nullable_to_non_nullable
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
  const OutputUpdate({required final  List<OutputLine> output, required this.isRunning, final  String? $type}): _output = output,$type = $type ?? 'outputUpdate';
  factory OutputUpdate.fromJson(Map<String, dynamic> json) => _$OutputUpdateFromJson(json);

 final  List<OutputLine> _output;
 List<OutputLine> get output {
  if (_output is EqualUnmodifiableListView) return _output;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_output);
}

 final  bool isRunning;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OutputUpdate&&const DeepCollectionEquality().equals(other._output, _output)&&(identical(other.isRunning, isRunning) || other.isRunning == isRunning));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_output),isRunning);

@override
String toString() {
  return 'Message.outputUpdate(output: $output, isRunning: $isRunning)';
}


}

/// @nodoc
abstract mixin class $OutputUpdateCopyWith<$Res> implements $MessageCopyWith<$Res> {
  factory $OutputUpdateCopyWith(OutputUpdate value, $Res Function(OutputUpdate) _then) = _$OutputUpdateCopyWithImpl;
@useResult
$Res call({
 List<OutputLine> output, bool isRunning
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
@pragma('vm:prefer-inline') $Res call({Object? output = null,Object? isRunning = null,}) {
  return _then(OutputUpdate(
output: null == output ? _self._output : output // ignore: cast_nullable_to_non_nullable
as List<OutputLine>,isRunning: null == isRunning ? _self.isRunning : isRunning // ignore: cast_nullable_to_non_nullable
as bool,
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
