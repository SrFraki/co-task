import 'package:freezed_annotation/freezed_annotation.dart';

part 'single_task_model.freezed.dart';

@unfreezed
class SingleTask with _$SingleTask{
  factory SingleTask({
    @Default('') String tasks,
    @Default(false) bool isCompleted,
  }) = _SingleTask;
}