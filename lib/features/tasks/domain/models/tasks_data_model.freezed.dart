// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tasks_data_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TasksData _$TasksDataFromJson(Map<String, dynamic> json) {
  return _TasksData.fromJson(json);
}

/// @nodoc
mixin _$TasksData {
  @JsonKey(name: "tasks")
  List<List<String>> get tasks => throw _privateConstructorUsedError;
  @JsonKey(name: "areComplted")
  List<List<dynamic>> get areCompleted => throw _privateConstructorUsedError;
  @JsonKey(name: "names_and_uid")
  List<String> get namesAndUids => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TasksDataCopyWith<TasksData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TasksDataCopyWith<$Res> {
  factory $TasksDataCopyWith(TasksData value, $Res Function(TasksData) then) =
      _$TasksDataCopyWithImpl<$Res, TasksData>;
  @useResult
  $Res call(
      {@JsonKey(name: "tasks") List<List<String>> tasks,
      @JsonKey(name: "areComplted") List<List<dynamic>> areCompleted,
      @JsonKey(name: "names_and_uid") List<String> namesAndUids});
}

/// @nodoc
class _$TasksDataCopyWithImpl<$Res, $Val extends TasksData>
    implements $TasksDataCopyWith<$Res> {
  _$TasksDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tasks = null,
    Object? areCompleted = null,
    Object? namesAndUids = null,
  }) {
    return _then(_value.copyWith(
      tasks: null == tasks
          ? _value.tasks
          : tasks // ignore: cast_nullable_to_non_nullable
              as List<List<String>>,
      areCompleted: null == areCompleted
          ? _value.areCompleted
          : areCompleted // ignore: cast_nullable_to_non_nullable
              as List<List<dynamic>>,
      namesAndUids: null == namesAndUids
          ? _value.namesAndUids
          : namesAndUids // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TasksDataImplCopyWith<$Res>
    implements $TasksDataCopyWith<$Res> {
  factory _$$TasksDataImplCopyWith(
          _$TasksDataImpl value, $Res Function(_$TasksDataImpl) then) =
      __$$TasksDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "tasks") List<List<String>> tasks,
      @JsonKey(name: "areComplted") List<List<dynamic>> areCompleted,
      @JsonKey(name: "names_and_uid") List<String> namesAndUids});
}

/// @nodoc
class __$$TasksDataImplCopyWithImpl<$Res>
    extends _$TasksDataCopyWithImpl<$Res, _$TasksDataImpl>
    implements _$$TasksDataImplCopyWith<$Res> {
  __$$TasksDataImplCopyWithImpl(
      _$TasksDataImpl _value, $Res Function(_$TasksDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tasks = null,
    Object? areCompleted = null,
    Object? namesAndUids = null,
  }) {
    return _then(_$TasksDataImpl(
      tasks: null == tasks
          ? _value._tasks
          : tasks // ignore: cast_nullable_to_non_nullable
              as List<List<String>>,
      areCompleted: null == areCompleted
          ? _value._areCompleted
          : areCompleted // ignore: cast_nullable_to_non_nullable
              as List<List<dynamic>>,
      namesAndUids: null == namesAndUids
          ? _value._namesAndUids
          : namesAndUids // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TasksDataImpl implements _TasksData {
  const _$TasksDataImpl(
      {@JsonKey(name: "tasks") required final List<List<String>> tasks,
      @JsonKey(name: "areComplted")
      required final List<List<dynamic>> areCompleted,
      @JsonKey(name: "names_and_uid") required final List<String> namesAndUids})
      : _tasks = tasks,
        _areCompleted = areCompleted,
        _namesAndUids = namesAndUids;

  factory _$TasksDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$TasksDataImplFromJson(json);

  final List<List<String>> _tasks;
  @override
  @JsonKey(name: "tasks")
  List<List<String>> get tasks {
    if (_tasks is EqualUnmodifiableListView) return _tasks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tasks);
  }

  final List<List<dynamic>> _areCompleted;
  @override
  @JsonKey(name: "areComplted")
  List<List<dynamic>> get areCompleted {
    if (_areCompleted is EqualUnmodifiableListView) return _areCompleted;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_areCompleted);
  }

  final List<String> _namesAndUids;
  @override
  @JsonKey(name: "names_and_uid")
  List<String> get namesAndUids {
    if (_namesAndUids is EqualUnmodifiableListView) return _namesAndUids;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_namesAndUids);
  }

  @override
  String toString() {
    return 'TasksData(tasks: $tasks, areCompleted: $areCompleted, namesAndUids: $namesAndUids)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TasksDataImpl &&
            const DeepCollectionEquality().equals(other._tasks, _tasks) &&
            const DeepCollectionEquality()
                .equals(other._areCompleted, _areCompleted) &&
            const DeepCollectionEquality()
                .equals(other._namesAndUids, _namesAndUids));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_tasks),
      const DeepCollectionEquality().hash(_areCompleted),
      const DeepCollectionEquality().hash(_namesAndUids));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TasksDataImplCopyWith<_$TasksDataImpl> get copyWith =>
      __$$TasksDataImplCopyWithImpl<_$TasksDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TasksDataImplToJson(
      this,
    );
  }
}

abstract class _TasksData implements TasksData {
  const factory _TasksData(
      {@JsonKey(name: "tasks") required final List<List<String>> tasks,
      @JsonKey(name: "areComplted")
      required final List<List<dynamic>> areCompleted,
      @JsonKey(name: "names_and_uid")
      required final List<String> namesAndUids}) = _$TasksDataImpl;

  factory _TasksData.fromJson(Map<String, dynamic> json) =
      _$TasksDataImpl.fromJson;

  @override
  @JsonKey(name: "tasks")
  List<List<String>> get tasks;
  @override
  @JsonKey(name: "areComplted")
  List<List<dynamic>> get areCompleted;
  @override
  @JsonKey(name: "names_and_uid")
  List<String> get namesAndUids;
  @override
  @JsonKey(ignore: true)
  _$$TasksDataImplCopyWith<_$TasksDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
