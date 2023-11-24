// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'group_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$GroupPState {
  Map<String, String> get names => throw _privateConstructorUsedError;
  set names(Map<String, String> value) => throw _privateConstructorUsedError;
  List<(String, Task)> get tasks => throw _privateConstructorUsedError;
  set tasks(List<(String, Task)> value) => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GroupPStateCopyWith<GroupPState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupPStateCopyWith<$Res> {
  factory $GroupPStateCopyWith(
          GroupPState value, $Res Function(GroupPState) then) =
      _$GroupPStateCopyWithImpl<$Res, GroupPState>;
  @useResult
  $Res call({Map<String, String> names, List<(String, Task)> tasks});
}

/// @nodoc
class _$GroupPStateCopyWithImpl<$Res, $Val extends GroupPState>
    implements $GroupPStateCopyWith<$Res> {
  _$GroupPStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? names = null,
    Object? tasks = null,
  }) {
    return _then(_value.copyWith(
      names: null == names
          ? _value.names
          : names // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      tasks: null == tasks
          ? _value.tasks
          : tasks // ignore: cast_nullable_to_non_nullable
              as List<(String, Task)>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GroupPStateImplCopyWith<$Res>
    implements $GroupPStateCopyWith<$Res> {
  factory _$$GroupPStateImplCopyWith(
          _$GroupPStateImpl value, $Res Function(_$GroupPStateImpl) then) =
      __$$GroupPStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Map<String, String> names, List<(String, Task)> tasks});
}

/// @nodoc
class __$$GroupPStateImplCopyWithImpl<$Res>
    extends _$GroupPStateCopyWithImpl<$Res, _$GroupPStateImpl>
    implements _$$GroupPStateImplCopyWith<$Res> {
  __$$GroupPStateImplCopyWithImpl(
      _$GroupPStateImpl _value, $Res Function(_$GroupPStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? names = null,
    Object? tasks = null,
  }) {
    return _then(_$GroupPStateImpl(
      names: null == names
          ? _value.names
          : names // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      tasks: null == tasks
          ? _value.tasks
          : tasks // ignore: cast_nullable_to_non_nullable
              as List<(String, Task)>,
    ));
  }
}

/// @nodoc

class _$GroupPStateImpl implements _GroupPState {
  _$GroupPStateImpl({this.names = const {}, this.tasks = const []});

  @override
  @JsonKey()
  Map<String, String> names;
  @override
  @JsonKey()
  List<(String, Task)> tasks;

  @override
  String toString() {
    return 'GroupPState(names: $names, tasks: $tasks)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GroupPStateImplCopyWith<_$GroupPStateImpl> get copyWith =>
      __$$GroupPStateImplCopyWithImpl<_$GroupPStateImpl>(this, _$identity);
}

abstract class _GroupPState implements GroupPState {
  factory _GroupPState(
      {Map<String, String> names,
      List<(String, Task)> tasks}) = _$GroupPStateImpl;

  @override
  Map<String, String> get names;
  set names(Map<String, String> value);
  @override
  List<(String, Task)> get tasks;
  set tasks(List<(String, Task)> value);
  @override
  @JsonKey(ignore: true)
  _$$GroupPStateImplCopyWith<_$GroupPStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
