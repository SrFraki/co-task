// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'single_task_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SingleTask {
  String get tasks => throw _privateConstructorUsedError;
  set tasks(String value) => throw _privateConstructorUsedError;
  bool get isCompleted => throw _privateConstructorUsedError;
  set isCompleted(bool value) => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SingleTaskCopyWith<SingleTask> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SingleTaskCopyWith<$Res> {
  factory $SingleTaskCopyWith(
          SingleTask value, $Res Function(SingleTask) then) =
      _$SingleTaskCopyWithImpl<$Res, SingleTask>;
  @useResult
  $Res call({String tasks, bool isCompleted});
}

/// @nodoc
class _$SingleTaskCopyWithImpl<$Res, $Val extends SingleTask>
    implements $SingleTaskCopyWith<$Res> {
  _$SingleTaskCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tasks = null,
    Object? isCompleted = null,
  }) {
    return _then(_value.copyWith(
      tasks: null == tasks
          ? _value.tasks
          : tasks // ignore: cast_nullable_to_non_nullable
              as String,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SingleTaskImplCopyWith<$Res>
    implements $SingleTaskCopyWith<$Res> {
  factory _$$SingleTaskImplCopyWith(
          _$SingleTaskImpl value, $Res Function(_$SingleTaskImpl) then) =
      __$$SingleTaskImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String tasks, bool isCompleted});
}

/// @nodoc
class __$$SingleTaskImplCopyWithImpl<$Res>
    extends _$SingleTaskCopyWithImpl<$Res, _$SingleTaskImpl>
    implements _$$SingleTaskImplCopyWith<$Res> {
  __$$SingleTaskImplCopyWithImpl(
      _$SingleTaskImpl _value, $Res Function(_$SingleTaskImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tasks = null,
    Object? isCompleted = null,
  }) {
    return _then(_$SingleTaskImpl(
      tasks: null == tasks
          ? _value.tasks
          : tasks // ignore: cast_nullable_to_non_nullable
              as String,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$SingleTaskImpl implements _SingleTask {
  _$SingleTaskImpl({this.tasks = '', this.isCompleted = false});

  @override
  @JsonKey()
  String tasks;
  @override
  @JsonKey()
  bool isCompleted;

  @override
  String toString() {
    return 'SingleTask(tasks: $tasks, isCompleted: $isCompleted)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SingleTaskImplCopyWith<_$SingleTaskImpl> get copyWith =>
      __$$SingleTaskImplCopyWithImpl<_$SingleTaskImpl>(this, _$identity);
}

abstract class _SingleTask implements SingleTask {
  factory _SingleTask({String tasks, bool isCompleted}) = _$SingleTaskImpl;

  @override
  String get tasks;
  set tasks(String value);
  @override
  bool get isCompleted;
  set isCompleted(bool value);
  @override
  @JsonKey(ignore: true)
  _$$SingleTaskImplCopyWith<_$SingleTaskImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
