import 'package:freezed_annotation/freezed_annotation.dart';

part 'task.freezed.dart';
part 'task.g.dart';

@unfreezed
class Task with _$Task{
  factory Task({
    @JsonKey(name: 'user') @Default(-1) int user,
    @JsonKey(name: 'task') @Default('') String task,
    @JsonKey(name: 'finalized') @Default(false) bool finalized,
    @JsonKey(name: 'accumulatedWeeks') @Default(0) int accumulatedWeeks
  }) = _Task;

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
}