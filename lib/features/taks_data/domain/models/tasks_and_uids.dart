import 'package:freezed_annotation/freezed_annotation.dart';

part 'tasks_and_uids.freezed.dart';
part 'tasks_and_uids.g.dart';


@freezed
class TasksAndUids with _$TasksAndUids{
  const factory TasksAndUids({
    @JsonKey(name: 'tasks') @Default([]) List<String> tasks,
    @JsonKey(name: 'groups_uids') @Default([]) List<String> uids
  }) = _TasksAndUids;

  factory TasksAndUids.fromJson(Map<String, dynamic> json) => _$TasksAndUidsFromJson(json);
}