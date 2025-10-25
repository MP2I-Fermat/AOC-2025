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
                  case 'codeUpdate':
          return CodeUpdate.fromJson(
            json
          );
                case 'startEvaluation':
          return StartEvaluation.fromJson(
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

 String get code;
/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MessageCopyWith<Message> get copyWith => _$MessageCopyWithImpl<Message>(this as Message, _$identity);

  /// Serializes this Message to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Message&&(identical(other.code, code) || other.code == code));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code);

@override
String toString() {
  return 'Message(code: $code)';
}


}

/// @nodoc
abstract mixin class $MessageCopyWith<$Res>  {
  factory $MessageCopyWith(Message value, $Res Function(Message) _then) = _$MessageCopyWithImpl;
@useResult
$Res call({
 String code
});




}
/// @nodoc
class _$MessageCopyWithImpl<$Res>
    implements $MessageCopyWith<$Res> {
  _$MessageCopyWithImpl(this._self, this._then);

  final Message _self;
  final $Res Function(Message) _then;

/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( CodeUpdate value)?  codeUpdate,TResult Function( StartEvaluation value)?  startEvaluation,required TResult orElse(),}){
final _that = this;
switch (_that) {
case CodeUpdate() when codeUpdate != null:
return codeUpdate(_that);case StartEvaluation() when startEvaluation != null:
return startEvaluation(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( CodeUpdate value)  codeUpdate,required TResult Function( StartEvaluation value)  startEvaluation,}){
final _that = this;
switch (_that) {
case CodeUpdate():
return codeUpdate(_that);case StartEvaluation():
return startEvaluation(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( CodeUpdate value)?  codeUpdate,TResult? Function( StartEvaluation value)?  startEvaluation,}){
final _that = this;
switch (_that) {
case CodeUpdate() when codeUpdate != null:
return codeUpdate(_that);case StartEvaluation() when startEvaluation != null:
return startEvaluation(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String code)?  codeUpdate,TResult Function( String code)?  startEvaluation,required TResult orElse(),}) {final _that = this;
switch (_that) {
case CodeUpdate() when codeUpdate != null:
return codeUpdate(_that.code);case StartEvaluation() when startEvaluation != null:
return startEvaluation(_that.code);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String code)  codeUpdate,required TResult Function( String code)  startEvaluation,}) {final _that = this;
switch (_that) {
case CodeUpdate():
return codeUpdate(_that.code);case StartEvaluation():
return startEvaluation(_that.code);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String code)?  codeUpdate,TResult? Function( String code)?  startEvaluation,}) {final _that = this;
switch (_that) {
case CodeUpdate() when codeUpdate != null:
return codeUpdate(_that.code);case StartEvaluation() when startEvaluation != null:
return startEvaluation(_that.code);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class CodeUpdate implements Message {
  const CodeUpdate({required this.code, final  String? $type}): $type = $type ?? 'codeUpdate';
  factory CodeUpdate.fromJson(Map<String, dynamic> json) => _$CodeUpdateFromJson(json);

@override final  String code;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
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
@override @useResult
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
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,}) {
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

@override final  String code;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
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
@override @useResult
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
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,}) {
  return _then(StartEvaluation(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
