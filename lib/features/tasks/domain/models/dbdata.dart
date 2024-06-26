import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:task_sharing/features/tasks/domain/models/task.dart';

part 'dbdata.freezed.dart';
part 'dbdata.g.dart';

@unfreezed
class DbData with _$DbData {
  factory DbData({
    @JsonKey(name: 'tasks') @Default([]) List<Task> tasks,
    @JsonKey(name: 'names') @Default([]) List<Name> names,
    @JsonKey(name: 'changeDay') @Default(0) int changeDay,
  }) = _DbData;

  factory DbData.fromJson(Map<String, dynamic> json) => _$DbDataFromJson(json);
}



@unfreezed
class Name with _$Name {
  factory Name({
    @JsonKey(name: 'uid') @Default('') String uid,
    @JsonKey(name: 'name') @Default('') String name,
    @JsonKey(name: 'token') @Default('') String token
  }) = _Name;

  factory Name.fromJson(Map<String, dynamic> json) => _$NameFromJson(json);
}