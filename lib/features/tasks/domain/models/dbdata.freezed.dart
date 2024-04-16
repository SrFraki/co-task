// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dbdata.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DbData _$DbDataFromJson(Map<String, dynamic> json) {
  return _DbData.fromJson(json);
}

/// @nodoc
mixin _$DbData {
  @JsonKey(name: 'tasks')
  List<Task> get tasks => throw _privateConstructorUsedError;
  @JsonKey(name: 'tasks')
  set tasks(List<Task> value) => throw _privateConstructorUsedError;
  @JsonKey(name: 'names')
  List<Name> get names => throw _privateConstructorUsedError;
  @JsonKey(name: 'names')
  set names(List<Name> value) => throw _privateConstructorUsedError;
  @JsonKey(name: 'changeDay')
  int get changeDay => throw _privateConstructorUsedError;
  @JsonKey(name: 'changeDay')
  set changeDay(int value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DbDataCopyWith<DbData> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DbDataCopyWith<$Res> {
  factory $DbDataCopyWith(DbData value, $Res Function(DbData) then) =
      _$DbDataCopyWithImpl<$Res, DbData>;
  @useResult
  $Res call(
      {@JsonKey(name: 'tasks') List<Task> tasks,
      @JsonKey(name: 'names') List<Name> names,
      @JsonKey(name: 'changeDay') int changeDay});
}

/// @nodoc
class _$DbDataCopyWithImpl<$Res, $Val extends DbData>
    implements $DbDataCopyWith<$Res> {
  _$DbDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tasks = null,
    Object? names = null,
    Object? changeDay = null,
  }) {
    return _then(_value.copyWith(
      tasks: null == tasks
          ? _value.tasks
          : tasks // ignore: cast_nullable_to_non_nullable
              as List<Task>,
      names: null == names
          ? _value.names
          : names // ignore: cast_nullable_to_non_nullable
              as List<Name>,
      changeDay: null == changeDay
          ? _value.changeDay
          : changeDay // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DbDataImplCopyWith<$Res> implements $DbDataCopyWith<$Res> {
  factory _$$DbDataImplCopyWith(
          _$DbDataImpl value, $Res Function(_$DbDataImpl) then) =
      __$$DbDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'tasks') List<Task> tasks,
      @JsonKey(name: 'names') List<Name> names,
      @JsonKey(name: 'changeDay') int changeDay});
}

/// @nodoc
class __$$DbDataImplCopyWithImpl<$Res>
    extends _$DbDataCopyWithImpl<$Res, _$DbDataImpl>
    implements _$$DbDataImplCopyWith<$Res> {
  __$$DbDataImplCopyWithImpl(
      _$DbDataImpl _value, $Res Function(_$DbDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tasks = null,
    Object? names = null,
    Object? changeDay = null,
  }) {
    return _then(_$DbDataImpl(
      tasks: null == tasks
          ? _value.tasks
          : tasks // ignore: cast_nullable_to_non_nullable
              as List<Task>,
      names: null == names
          ? _value.names
          : names // ignore: cast_nullable_to_non_nullable
              as List<Name>,
      changeDay: null == changeDay
          ? _value.changeDay
          : changeDay // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DbDataImpl implements _DbData {
  _$DbDataImpl(
      {@JsonKey(name: 'tasks') this.tasks = const [],
      @JsonKey(name: 'names') this.names = const [],
      @JsonKey(name: 'changeDay') this.changeDay = 0});

  factory _$DbDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$DbDataImplFromJson(json);

  @override
  @JsonKey(name: 'tasks')
  List<Task> tasks;
  @override
  @JsonKey(name: 'names')
  List<Name> names;
  @override
  @JsonKey(name: 'changeDay')
  int changeDay;

  @override
  String toString() {
    return 'DbData(tasks: $tasks, names: $names, changeDay: $changeDay)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DbDataImplCopyWith<_$DbDataImpl> get copyWith =>
      __$$DbDataImplCopyWithImpl<_$DbDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DbDataImplToJson(
      this,
    );
  }
}

abstract class _DbData implements DbData {
  factory _DbData(
      {@JsonKey(name: 'tasks') List<Task> tasks,
      @JsonKey(name: 'names') List<Name> names,
      @JsonKey(name: 'changeDay') int changeDay}) = _$DbDataImpl;

  factory _DbData.fromJson(Map<String, dynamic> json) = _$DbDataImpl.fromJson;

  @override
  @JsonKey(name: 'tasks')
  List<Task> get tasks;
  @JsonKey(name: 'tasks')
  set tasks(List<Task> value);
  @override
  @JsonKey(name: 'names')
  List<Name> get names;
  @JsonKey(name: 'names')
  set names(List<Name> value);
  @override
  @JsonKey(name: 'changeDay')
  int get changeDay;
  @JsonKey(name: 'changeDay')
  set changeDay(int value);
  @override
  @JsonKey(ignore: true)
  _$$DbDataImplCopyWith<_$DbDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Name _$NameFromJson(Map<String, dynamic> json) {
  return _Name.fromJson(json);
}

/// @nodoc
mixin _$Name {
  @JsonKey(name: 'uid')
  String get uid => throw _privateConstructorUsedError;
  @JsonKey(name: 'name')
  String get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NameCopyWith<Name> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NameCopyWith<$Res> {
  factory $NameCopyWith(Name value, $Res Function(Name) then) =
      _$NameCopyWithImpl<$Res, Name>;
  @useResult
  $Res call(
      {@JsonKey(name: 'uid') String uid, @JsonKey(name: 'name') String name});
}

/// @nodoc
class _$NameCopyWithImpl<$Res, $Val extends Name>
    implements $NameCopyWith<$Res> {
  _$NameCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? name = null,
  }) {
    return _then(_value.copyWith(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NameImplCopyWith<$Res> implements $NameCopyWith<$Res> {
  factory _$$NameImplCopyWith(
          _$NameImpl value, $Res Function(_$NameImpl) then) =
      __$$NameImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'uid') String uid, @JsonKey(name: 'name') String name});
}

/// @nodoc
class __$$NameImplCopyWithImpl<$Res>
    extends _$NameCopyWithImpl<$Res, _$NameImpl>
    implements _$$NameImplCopyWith<$Res> {
  __$$NameImplCopyWithImpl(_$NameImpl _value, $Res Function(_$NameImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? name = null,
  }) {
    return _then(_$NameImpl(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NameImpl implements _Name {
  const _$NameImpl(
      {@JsonKey(name: 'uid') this.uid = '',
      @JsonKey(name: 'name') this.name = ''});

  factory _$NameImpl.fromJson(Map<String, dynamic> json) =>
      _$$NameImplFromJson(json);

  @override
  @JsonKey(name: 'uid')
  final String uid;
  @override
  @JsonKey(name: 'name')
  final String name;

  @override
  String toString() {
    return 'Name(uid: $uid, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NameImpl &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, uid, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NameImplCopyWith<_$NameImpl> get copyWith =>
      __$$NameImplCopyWithImpl<_$NameImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NameImplToJson(
      this,
    );
  }
}

abstract class _Name implements Name {
  const factory _Name(
      {@JsonKey(name: 'uid') final String uid,
      @JsonKey(name: 'name') final String name}) = _$NameImpl;

  factory _Name.fromJson(Map<String, dynamic> json) = _$NameImpl.fromJson;

  @override
  @JsonKey(name: 'uid')
  String get uid;
  @override
  @JsonKey(name: 'name')
  String get name;
  @override
  @JsonKey(ignore: true)
  _$$NameImplCopyWith<_$NameImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
