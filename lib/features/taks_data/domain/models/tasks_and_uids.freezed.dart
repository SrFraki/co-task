// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tasks_and_uids.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TasksAndUids _$TasksAndUidsFromJson(Map<String, dynamic> json) {
  return _TasksAndUids.fromJson(json);
}

/// @nodoc
mixin _$TasksAndUids {
  @JsonKey(name: 'tasks')
  List<String> get tasks => throw _privateConstructorUsedError;
  @JsonKey(name: 'groups_uids')
  List<String> get uids => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TasksAndUidsCopyWith<TasksAndUids> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TasksAndUidsCopyWith<$Res> {
  factory $TasksAndUidsCopyWith(
          TasksAndUids value, $Res Function(TasksAndUids) then) =
      _$TasksAndUidsCopyWithImpl<$Res, TasksAndUids>;
  @useResult
  $Res call(
      {@JsonKey(name: 'tasks') List<String> tasks,
      @JsonKey(name: 'groups_uids') List<String> uids});
}

/// @nodoc
class _$TasksAndUidsCopyWithImpl<$Res, $Val extends TasksAndUids>
    implements $TasksAndUidsCopyWith<$Res> {
  _$TasksAndUidsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tasks = null,
    Object? uids = null,
  }) {
    return _then(_value.copyWith(
      tasks: null == tasks
          ? _value.tasks
          : tasks // ignore: cast_nullable_to_non_nullable
              as List<String>,
      uids: null == uids
          ? _value.uids
          : uids // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TasksAndUidsImplCopyWith<$Res>
    implements $TasksAndUidsCopyWith<$Res> {
  factory _$$TasksAndUidsImplCopyWith(
          _$TasksAndUidsImpl value, $Res Function(_$TasksAndUidsImpl) then) =
      __$$TasksAndUidsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'tasks') List<String> tasks,
      @JsonKey(name: 'groups_uids') List<String> uids});
}

/// @nodoc
class __$$TasksAndUidsImplCopyWithImpl<$Res>
    extends _$TasksAndUidsCopyWithImpl<$Res, _$TasksAndUidsImpl>
    implements _$$TasksAndUidsImplCopyWith<$Res> {
  __$$TasksAndUidsImplCopyWithImpl(
      _$TasksAndUidsImpl _value, $Res Function(_$TasksAndUidsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tasks = null,
    Object? uids = null,
  }) {
    return _then(_$TasksAndUidsImpl(
      tasks: null == tasks
          ? _value._tasks
          : tasks // ignore: cast_nullable_to_non_nullable
              as List<String>,
      uids: null == uids
          ? _value._uids
          : uids // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TasksAndUidsImpl implements _TasksAndUids {
  const _$TasksAndUidsImpl(
      {@JsonKey(name: 'tasks') final List<String> tasks = const [],
      @JsonKey(name: 'groups_uids') final List<String> uids = const []})
      : _tasks = tasks,
        _uids = uids;

  factory _$TasksAndUidsImpl.fromJson(Map<String, dynamic> json) =>
      _$$TasksAndUidsImplFromJson(json);

  final List<String> _tasks;
  @override
  @JsonKey(name: 'tasks')
  List<String> get tasks {
    if (_tasks is EqualUnmodifiableListView) return _tasks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tasks);
  }

  final List<String> _uids;
  @override
  @JsonKey(name: 'groups_uids')
  List<String> get uids {
    if (_uids is EqualUnmodifiableListView) return _uids;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_uids);
  }

  @override
  String toString() {
    return 'TasksAndUids(tasks: $tasks, uids: $uids)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TasksAndUidsImpl &&
            const DeepCollectionEquality().equals(other._tasks, _tasks) &&
            const DeepCollectionEquality().equals(other._uids, _uids));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_tasks),
      const DeepCollectionEquality().hash(_uids));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TasksAndUidsImplCopyWith<_$TasksAndUidsImpl> get copyWith =>
      __$$TasksAndUidsImplCopyWithImpl<_$TasksAndUidsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TasksAndUidsImplToJson(
      this,
    );
  }
}

abstract class _TasksAndUids implements TasksAndUids {
  const factory _TasksAndUids(
          {@JsonKey(name: 'tasks') final List<String> tasks,
          @JsonKey(name: 'groups_uids') final List<String> uids}) =
      _$TasksAndUidsImpl;

  factory _TasksAndUids.fromJson(Map<String, dynamic> json) =
      _$TasksAndUidsImpl.fromJson;

  @override
  @JsonKey(name: 'tasks')
  List<String> get tasks;
  @override
  @JsonKey(name: 'groups_uids')
  List<String> get uids;
  @override
  @JsonKey(ignore: true)
  _$$TasksAndUidsImplCopyWith<_$TasksAndUidsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
