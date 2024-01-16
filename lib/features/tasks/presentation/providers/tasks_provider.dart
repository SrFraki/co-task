import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:task_sharing/features/auth/presentation/providers/auth_provider.dart';
import 'package:task_sharing/features/tasks/domain/models/tasks_data_model.dart';
import 'package:task_sharing/features/tasks/presentation/providers/task_repository_provider.dart';


part 'tasks_provider.g.dart';
part 'tasks_provider.freezed.dart';

@Riverpod(keepAlive: true)
class TasksP extends _$TasksP {
  @override
  TasksPState build() {
    return TasksPState();
  }



  void toggleIsCompleted(int pos){
    final completedTasks = state.areCompleted;
    completedTasks[state.pos][pos] = !(completedTasks[state.pos][pos]);
    final ownAreCompleted = state.ownAreCompleted;
    ownAreCompleted[pos] = (ownAreCompleted[pos]) == true;
    state = state.copyWith(areCompleted: completedTasks, ownAreCompleted: ownAreCompleted);
    ref.read(taskRepositoryProvider).toggleComplete(ownAreCompleted[pos], state.pos, pos);
  }

  void init() async {
    final TasksData? data = await ref.read(taskRepositoryProvider).getData();
    if(data == null) return;

    List<String> names = [];
    List<List<String>> tasks = [];
    List<List<bool>> areCompleted = [];
    List<int> simplifiedList = [];
    final uid = ref.read(authProvider).uid;
    int pos = -1;
    

    //TODO: get stored POS, else:
    data.namesAndUids.asMap().forEach((listKey, value) {
      if(value.contains(uid)){
        pos = listKey;
      }
      names.add(value.split('-').first);
      tasks.add(data.tasks[listKey].where((e) => e != '__null__').toList());
      areCompleted.add(data.areCompleted[listKey].where((e) => e != '__null__').map((e) => e == true).toList());
      if(tasks[listKey].isNotEmpty) simplifiedList.add(listKey);
    });


    state = state.copyWith(
      names: names,
      tasks: tasks,
      areCompleted: areCompleted,
      pos: pos,
      ownAreCompleted: areCompleted[pos].isEmpty ? [true] : areCompleted[pos],
      ownTasks: tasks[pos].isEmpty ? ['NO TIENES TAREAS'] : tasks[pos],
      simplifiedList: simplifiedList
    );

    FlutterNativeSplash.remove();

    ref.read(taskRepositoryProvider).listener().listen((event) {
      updateChanges(event);
    });

  }


  void updateChanges((int, int, bool) data){
    if(data.$1 != -1){
        var areCompleted = state.areCompleted;
        areCompleted[data.$1][data.$2] = data.$3;
        state = state.copyWith(areCompleted: areCompleted);
      }
  }


}


@unfreezed
class TasksPState with _$TasksPState {
    factory TasksPState({
        @Default([]) List<String> names,
        @Default([]) List<List<String>> tasks,
        @Default([]) List<List<bool>> areCompleted,
        @Default([]) List<String> ownTasks,
        @Default([]) List<bool> ownAreCompleted,
        @Default([]) List<int> simplifiedList,
        @Default(0) int pos
    }) = _TasksPState;
}


