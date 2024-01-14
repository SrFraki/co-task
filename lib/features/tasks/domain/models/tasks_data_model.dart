import 'package:freezed_annotation/freezed_annotation.dart';

part 'tasks_data_model.freezed.dart';
part 'tasks_data_model.g.dart';

@freezed
class TasksData with _$TasksData {
    const factory TasksData({
        @JsonKey(name: "tasks") required List<List<String>> tasks,
        @JsonKey(name: "areComplted") required List<List<dynamic>> areCompleted,
        @JsonKey(name: "names_and_uid") required List<String> namesAndUids
    }) = _TasksData;

    factory TasksData.fromJson(Map<String, dynamic> json) => _$TasksDataFromJson(json);
}