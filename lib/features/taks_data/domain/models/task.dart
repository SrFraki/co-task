import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'task.freezed.dart';
part 'task.g.dart';

@unfreezed
class Task with _$Task {
    factory Task({
        @JsonKey(name: "task") @Default('')
        String task,
        @JsonKey(name: "isCompleted") @Default(false)
        bool isCompleted,
        @JsonKey(includeFromJson: false, includeToJson: false)
        IconData? icon
    }) = _Task;

    factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
}
