// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TaskPState {
  bool get loadCompleted => throw _privateConstructorUsedError;
  set loadCompleted(bool value) => throw _privateConstructorUsedError;
  List<Task> get tasks => throw _privateConstructorUsedError;
  set tasks(List<Task> value) => throw _privateConstructorUsedError;
  Group? get group => throw _privateConstructorUsedError;
  set group(Group? value) => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TaskPStateCopyWith<TaskPState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskPStateCopyWith<$Res> {
  factory $TaskPStateCopyWith(
          TaskPState value, $Res Function(TaskPState) then) =
      _$TaskPStateCopyWithImpl<$Res, TaskPState>;
  @useResult
  $Res call({bool loadCompleted, List<Task> tasks, Group? group});

  $GroupCopyWith<$Res>? get group;
}

/// @nodoc
class _$TaskPStateCopyWithImpl<$Res, $Val extends TaskPState>
    implements $TaskPStateCopyWith<$Res> {
  _$TaskPStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loadCompleted = null,
    Object? tasks = null,
    Object? group = freezed,
  }) {
    return _then(_value.copyWith(
      loadCompleted: null == loadCompleted
          ? _value.loadCompleted
          : loadCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      tasks: null == tasks
          ? _value.tasks
          : tasks // ignore: cast_nullable_to_non_nullable
              as List<Task>,
      group: freezed == group
          ? _value.group
          : group // ignore: cast_nullable_to_non_nullable
              as Group?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $GroupCopyWith<$Res>? get group {
    if (_value.group == null) {
      return null;
    }

    return $GroupCopyWith<$Res>(_value.group!, (value) {
      return _then(_value.copyWith(group: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TaskPStateImplCopyWith<$Res>
    implements $TaskPStateCopyWith<$Res> {
  factory _$$TaskPStateImplCopyWith(
          _$TaskPStateImpl value, $Res Function(_$TaskPStateImpl) then) =
      __$$TaskPStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool loadCompleted, List<Task> tasks, Group? group});

  @override
  $GroupCopyWith<$Res>? get group;
}

/// @nodoc
class __$$TaskPStateImplCopyWithImpl<$Res>
    extends _$TaskPStateCopyWithImpl<$Res, _$TaskPStateImpl>
    implements _$$TaskPStateImplCopyWith<$Res> {
  __$$TaskPStateImplCopyWithImpl(
      _$TaskPStateImpl _value, $Res Function(_$TaskPStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loadCompleted = null,
    Object? tasks = null,
    Object? group = freezed,
  }) {
    return _then(_$TaskPStateImpl(
      loadCompleted: null == loadCompleted
          ? _value.loadCompleted
          : loadCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      tasks: null == tasks
          ? _value.tasks
          : tasks // ignore: cast_nullable_to_non_nullable
              as List<Task>,
      group: freezed == group
          ? _value.group
          : group // ignore: cast_nullable_to_non_nullable
              as Group?,
    ));
  }
}

/// @nodoc

class _$TaskPStateImpl implements _TaskPState {
  _$TaskPStateImpl(
      {this.loadCompleted = false, this.tasks = const [], this.group});

  @override
  @JsonKey()
  bool loadCompleted;
  @override
  @JsonKey()
  List<Task> tasks;
  @override
  Group? group;

  @override
  String toString() {
    return 'TaskPState(loadCompleted: $loadCompleted, tasks: $tasks, group: $group)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskPStateImplCopyWith<_$TaskPStateImpl> get copyWith =>
      __$$TaskPStateImplCopyWithImpl<_$TaskPStateImpl>(this, _$identity);
}

abstract class _TaskPState implements TaskPState {
  factory _TaskPState({bool loadCompleted, List<Task> tasks, Group? group}) =
      _$TaskPStateImpl;

  @override
  bool get loadCompleted;
  set loadCompleted(bool value);
  @override
  List<Task> get tasks;
  set tasks(List<Task> value);
  @override
  Group? get group;
  set group(Group? value);
  @override
  @JsonKey(ignore: true)
  _$$TaskPStateImplCopyWith<_$TaskPStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
