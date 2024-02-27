// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Task _$TaskFromJson(Map<String, dynamic> json) {
  return _Task.fromJson(json);
}

/// @nodoc
mixin _$Task {
  @JsonKey(name: 'user')
  int get user => throw _privateConstructorUsedError;
  @JsonKey(name: 'user')
  set user(int value) => throw _privateConstructorUsedError;
  @JsonKey(name: 'task')
  String get task => throw _privateConstructorUsedError;
  @JsonKey(name: 'task')
  set task(String value) => throw _privateConstructorUsedError;
  @JsonKey(name: 'finalized')
  bool get finalized => throw _privateConstructorUsedError;
  @JsonKey(name: 'finalized')
  set finalized(bool value) => throw _privateConstructorUsedError;
  @JsonKey(name: 'accumulatedWeeks')
  int get accumulatedWeeks => throw _privateConstructorUsedError;
  @JsonKey(name: 'accumulatedWeeks')
  set accumulatedWeeks(int value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TaskCopyWith<Task> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskCopyWith<$Res> {
  factory $TaskCopyWith(Task value, $Res Function(Task) then) =
      _$TaskCopyWithImpl<$Res, Task>;
  @useResult
  $Res call(
      {@JsonKey(name: 'user') int user,
      @JsonKey(name: 'task') String task,
      @JsonKey(name: 'finalized') bool finalized,
      @JsonKey(name: 'accumulatedWeeks') int accumulatedWeeks});
}

/// @nodoc
class _$TaskCopyWithImpl<$Res, $Val extends Task>
    implements $TaskCopyWith<$Res> {
  _$TaskCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
    Object? task = null,
    Object? finalized = null,
    Object? accumulatedWeeks = null,
  }) {
    return _then(_value.copyWith(
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as int,
      task: null == task
          ? _value.task
          : task // ignore: cast_nullable_to_non_nullable
              as String,
      finalized: null == finalized
          ? _value.finalized
          : finalized // ignore: cast_nullable_to_non_nullable
              as bool,
      accumulatedWeeks: null == accumulatedWeeks
          ? _value.accumulatedWeeks
          : accumulatedWeeks // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TaskImplCopyWith<$Res> implements $TaskCopyWith<$Res> {
  factory _$$TaskImplCopyWith(
          _$TaskImpl value, $Res Function(_$TaskImpl) then) =
      __$$TaskImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'user') int user,
      @JsonKey(name: 'task') String task,
      @JsonKey(name: 'finalized') bool finalized,
      @JsonKey(name: 'accumulatedWeeks') int accumulatedWeeks});
}

/// @nodoc
class __$$TaskImplCopyWithImpl<$Res>
    extends _$TaskCopyWithImpl<$Res, _$TaskImpl>
    implements _$$TaskImplCopyWith<$Res> {
  __$$TaskImplCopyWithImpl(_$TaskImpl _value, $Res Function(_$TaskImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
    Object? task = null,
    Object? finalized = null,
    Object? accumulatedWeeks = null,
  }) {
    return _then(_$TaskImpl(
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as int,
      task: null == task
          ? _value.task
          : task // ignore: cast_nullable_to_non_nullable
              as String,
      finalized: null == finalized
          ? _value.finalized
          : finalized // ignore: cast_nullable_to_non_nullable
              as bool,
      accumulatedWeeks: null == accumulatedWeeks
          ? _value.accumulatedWeeks
          : accumulatedWeeks // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TaskImpl implements _Task {
  _$TaskImpl(
      {@JsonKey(name: 'user') this.user = -1,
      @JsonKey(name: 'task') this.task = '',
      @JsonKey(name: 'finalized') this.finalized = false,
      @JsonKey(name: 'accumulatedWeeks') this.accumulatedWeeks = 0});

  factory _$TaskImpl.fromJson(Map<String, dynamic> json) =>
      _$$TaskImplFromJson(json);

  @override
  @JsonKey(name: 'user')
  int user;
  @override
  @JsonKey(name: 'task')
  String task;
  @override
  @JsonKey(name: 'finalized')
  bool finalized;
  @override
  @JsonKey(name: 'accumulatedWeeks')
  int accumulatedWeeks;

  @override
  String toString() {
    return 'Task(user: $user, task: $task, finalized: $finalized, accumulatedWeeks: $accumulatedWeeks)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskImplCopyWith<_$TaskImpl> get copyWith =>
      __$$TaskImplCopyWithImpl<_$TaskImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TaskImplToJson(
      this,
    );
  }
}

abstract class _Task implements Task {
  factory _Task(
      {@JsonKey(name: 'user') int user,
      @JsonKey(name: 'task') String task,
      @JsonKey(name: 'finalized') bool finalized,
      @JsonKey(name: 'accumulatedWeeks') int accumulatedWeeks}) = _$TaskImpl;

  factory _Task.fromJson(Map<String, dynamic> json) = _$TaskImpl.fromJson;

  @override
  @JsonKey(name: 'user')
  int get user;
  @JsonKey(name: 'user')
  set user(int value);
  @override
  @JsonKey(name: 'task')
  String get task;
  @JsonKey(name: 'task')
  set task(String value);
  @override
  @JsonKey(name: 'finalized')
  bool get finalized;
  @JsonKey(name: 'finalized')
  set finalized(bool value);
  @override
  @JsonKey(name: 'accumulatedWeeks')
  int get accumulatedWeeks;
  @JsonKey(name: 'accumulatedWeeks')
  set accumulatedWeeks(int value);
  @override
  @JsonKey(ignore: true)
  _$$TaskImplCopyWith<_$TaskImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
