import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:task_sharing/features/taks_data/domain/models/task.dart';

part 'group.freezed.dart';
part 'group.g.dart';

@freezed
class Group with _$Group {
    const factory Group({
        @JsonKey(name: "group") @Default({})
        Map<String, Task> group,
    }) = _Group;

    factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);

    // @override
    // Map<String, dynamic> toJson() => {
    //   "group":{
        
    //   }
    // };
}
