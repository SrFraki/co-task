import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:task_sharing/features/taks_data/domain/models/task.dart';

part 'group.freezed.dart';

@unfreezed
class Group with _$Group {
    factory Group({
        @Default({})
        Map<String, List<Task>> group,
    }) = _Group;



    factory Group.fromJson(Map<String, dynamic> json){
      final result = <String, List<Task>>{};
      for(String uid in json.keys){
        result.addAll({
          uid:(json[uid] as List<dynamic>).map((e) => Task.fromJson(e)).toList()
        });
      }
      return Group(group: result);
    }


    Map<String, dynamic> toJson(){
      final result = <String, dynamic>{};
      for(String uid in group.keys){
        result.addAll({
          uid:group[uid]?.map((e) => e.toJson()).toList()
        });
      }
      return {'group':result};
    }
}
