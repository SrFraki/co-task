// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tasks_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TasksPState {
  List<Name> get names => throw _privateConstructorUsedError;
  set names(List<Name> value) => throw _privateConstructorUsedError;
  List<Task> get tasks => throw _privateConstructorUsedError;
  set tasks(List<Task> value) => throw _privateConstructorUsedError;
  List<Task> get ownTasks => throw _privateConstructorUsedError;
  set ownTasks(List<Task> value) => throw _privateConstructorUsedError;
  List<Task> get lastWeekTasks => throw _privateConstructorUsedError;
  set lastWeekTasks(List<Task> value) => throw _privateConstructorUsedError;
  int get user => throw _privateConstructorUsedError;
  set user(int value) => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TasksPStateCopyWith<TasksPState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TasksPStateCopyWith<$Res> {
  factory $TasksPStateCopyWith(
          TasksPState value, $Res Function(TasksPState) then) =
      _$TasksPStateCopyWithImpl<$Res, TasksPState>;
  @useResult
  $Res call(
      {List<Name> names,
      List<Task> tasks,
      List<Task> ownTasks,
      List<Task> lastWeekTasks,
      int user});
}

/// @nodoc
class _$TasksPStateCopyWithImpl<$Res, $Val extends TasksPState>
    implements $TasksPStateCopyWith<$Res> {
  _$TasksPStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? names = null,
    Object? tasks = null,
    Object? ownTasks = null,
    Object? lastWeekTasks = null,
    Object? user = null,
  }) {
    return _then(_value.copyWith(
      names: null == names
          ? _value.names
          : names // ignore: cast_nullable_to_non_nullable
              as List<Name>,
      tasks: null == tasks
          ? _value.tasks
          : tasks // ignore: cast_nullable_to_non_nullable
              as List<Task>,
      ownTasks: null == ownTasks
          ? _value.ownTasks
          : ownTasks // ignore: cast_nullable_to_non_nullable
              as List<Task>,
      lastWeekTasks: null == lastWeekTasks
          ? _value.lastWeekTasks
          : lastWeekTasks // ignore: cast_nullable_to_non_nullable
              as List<Task>,
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TasksPStateImplCopyWith<$Res>
    implements $TasksPStateCopyWith<$Res> {
  factory _$$TasksPStateImplCopyWith(
          _$TasksPStateImpl value, $Res Function(_$TasksPStateImpl) then) =
      __$$TasksPStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Name> names,
      List<Task> tasks,
      List<Task> ownTasks,
      List<Task> lastWeekTasks,
      int user});
}

/// @nodoc
class __$$TasksPStateImplCopyWithImpl<$Res>
    extends _$TasksPStateCopyWithImpl<$Res, _$TasksPStateImpl>
    implements _$$TasksPStateImplCopyWith<$Res> {
  __$$TasksPStateImplCopyWithImpl(
      _$TasksPStateImpl _value, $Res Function(_$TasksPStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? names = null,
    Object? tasks = null,
    Object? ownTasks = null,
    Object? lastWeekTasks = null,
    Object? user = null,
  }) {
    return _then(_$TasksPStateImpl(
      names: null == names
          ? _value.names
          : names // ignore: cast_nullable_to_non_nullable
              as List<Name>,
      tasks: null == tasks
          ? _value.tasks
          : tasks // ignore: cast_nullable_to_non_nullable
              as List<Task>,
      ownTasks: null == ownTasks
          ? _value.ownTasks
          : ownTasks // ignore: cast_nullable_to_non_nullable
              as List<Task>,
      lastWeekTasks: null == lastWeekTasks
          ? _value.lastWeekTasks
          : lastWeekTasks // ignore: cast_nullable_to_non_nullable
              as List<Task>,
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$TasksPStateImpl implements _TasksPState {
  _$TasksPStateImpl(
      {this.names = const [],
      this.tasks = const [],
      this.ownTasks = const [],
      this.lastWeekTasks = const [],
      this.user = 0});

  @override
  @JsonKey()
  List<Name> names;
  @override
  @JsonKey()
  List<Task> tasks;
  @override
  @JsonKey()
  List<Task> ownTasks;
  @override
  @JsonKey()
  List<Task> lastWeekTasks;
  @override
  @JsonKey()
  int user;

  @override
  String toString() {
    return 'TasksPState(names: $names, tasks: $tasks, ownTasks: $ownTasks, lastWeekTasks: $lastWeekTasks, user: $user)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TasksPStateImplCopyWith<_$TasksPStateImpl> get copyWith =>
      __$$TasksPStateImplCopyWithImpl<_$TasksPStateImpl>(this, _$identity);
}

abstract class _TasksPState implements TasksPState {
  factory _TasksPState(
      {List<Name> names,
      List<Task> tasks,
      List<Task> ownTasks,
      List<Task> lastWeekTasks,
      int user}) = _$TasksPStateImpl;

  @override
  List<Name> get names;
  set names(List<Name> value);
  @override
  List<Task> get tasks;
  set tasks(List<Task> value);
  @override
  List<Task> get ownTasks;
  set ownTasks(List<Task> value);
  @override
  List<Task> get lastWeekTasks;
  set lastWeekTasks(List<Task> value);
  @override
  int get user;
  set user(int value);
  @override
  @JsonKey(ignore: true)
  _$$TasksPStateImplCopyWith<_$TasksPStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
