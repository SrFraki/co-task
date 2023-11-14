import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:task_sharing/features/taks_data/domain/models/task.dart';

part 'group.freezed.dart';
part 'group.g.dart';

@unfreezed
class Group with _$Group {
    factory Group({
        @JsonKey(name: "group") @Default({})
        Map<String, List<Task>> group,
    }) = _Group;

    factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);
}
