import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:task_sharing/features/taks_data/presentation/providers/task_repository_provider.dart';

import '../../domain/models/task.dart';

part 'group_provider.g.dart';
part 'group_provider.freezed.dart';

@Riverpod(keepAlive: true)
class GroupP extends _$GroupP {
  @override
  GroupPState build() {
    getNames().then((_) => init());
    return GroupPState();
  }


  Future<void> init() async {
    final g = await ref.read(taskRepositoryProvider).getGroup();
    final list = <(String, Task)>[];

    g.group.forEach((key, value) async {
      for(Task task in value){
        list.add((state.names[key] ?? '', task));
      }
    });
    state = state.copyWith(tasks: list);
  }

  Future<void> getNames() async{
    final names = await ref.read(taskRepositoryProvider).getNames() ?? ([],[]);
    final Map<String, String> result = {};
    for(int i=0; i<names.$1.length; i++){
      result[names.$2[i]] = names.$1[i];
    }
    print(names.$2);
    state = state.copyWith(names: result);
  }

}

@unfreezed
class GroupPState with _$GroupPState{
  factory GroupPState({
    @Default({}) Map<String, String> names,
    @Default([]) List<(String, Task)> tasks
  }) = _GroupPState;
}
