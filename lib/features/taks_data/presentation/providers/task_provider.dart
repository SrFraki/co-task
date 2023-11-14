import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:task_sharing/config/constants/icons_consts.dart';
import 'package:task_sharing/features/auth/presentation/providers/auth_provider.dart';
import 'package:task_sharing/features/shared/infrastructure/services/time_service.dart';
import 'package:task_sharing/features/taks_data/domain/models/group.dart';
import 'package:task_sharing/features/taks_data/domain/models/tasks_and_uids.dart';
import 'package:task_sharing/features/taks_data/presentation/providers/task_repository_provider.dart';

import '../../domain/models/task.dart';

part 'task_provider.g.dart';

@Riverpod(keepAlive: true)
class TaskP extends _$TaskP {
  @override
  TaskPState build() => TaskPState();

  Future<void> load() async {
    if(state.loadCompleted) return;
    state = state.copyWith(loadCompleted: true);

    final DateTime dbDate = await ref.read(taskRepositoryProvider).getLastWeekMon();
    final String uid = ref.read(authProvider).uid;
    List<Task>? task;

    if(TimeService.compare(dbDate, TimeService.lastWeekMon)){
      ///1) Rotar lista de tareas
      TasksAndUids tasksAndUids = await ref.read(taskRepositoryProvider).getTasksAndUids();
      List<String> tasks = [...tasksAndUids.tasks];
      String firstE = tasks.removeAt(0);
      tasks.add(firstE);
      await ref.read(taskRepositoryProvider).updateTasks(tasks);
      
      ///2) Asignar tareas
      ///2.1) COMPROBAR NO COMPLETADOS
      
      final lastWeekGroup = await ref.read(taskRepositoryProvider).getGroup();
      Group uidsPunished = Group();
      lastWeekGroup.group.forEach((key, value) { 
        List<Task> uncompletedTasks = [];
        for (var element in value) { if(!element.isCompleted) uncompletedTasks.add(element); }
        if(uncompletedTasks.isNotEmpty){
          uidsPunished.group[key] = uncompletedTasks;
        }
      });

      Map<String, List<Task>> g = <String, List<Task>>{};
      for(int i=0; i<tasksAndUids.tasks.length; i++){
        final moreTasks = uidsPunished.group.containsKey(tasksAndUids.uids[i]) ? uidsPunished.group[tasksAndUids.uids[i]]! : <Task>[];
        g.addAll({
          tasksAndUids.uids[i]:[
            Task(
              task: tasksAndUids.tasks[i],
              isCompleted: false
            ),
            ...moreTasks
          ]
        });
        if(tasksAndUids.uids[i] == uid){
          task = [Task(task: tasksAndUids.tasks[i], isCompleted: false), ...moreTasks];
        }
      }
      await ref.read(taskRepositoryProvider).assignTasks(Group(group: g));

      ///3) Acutalizar last_week
      await ref.read(taskRepositoryProvider).updateLastWeekMon(TimeService.lastWeekMon);
    }else{
      task = await ref.read(taskRepositoryProvider).getSingleTask(uid);
    }


    for (var element in task ?? []) {
      element.icon = IconConstant.getIcon(element.task);
    }
    state = state.copyWith(tasks: task ?? [Task(task: 'ERROR 404', isCompleted: false, icon: IconConstant.getIcon())]);
  }

  void toggleComplete(int index){
    final String uid = ref.read(authProvider).uid;
    final auxTasks = state.tasks;
    auxTasks[index] = Task(
      task: auxTasks[index].task,
      isCompleted: !(auxTasks[index].isCompleted),
    );
    state = state.copyWith(tasks: auxTasks);
    ref.read(taskRepositoryProvider).updateSingleTask(state.tasks, uid);
  }
}


class TaskPState{
  bool loadCompleted;
  List<Task> tasks;

  TaskPState({
    this.loadCompleted = false,
    this.tasks = const[]
  });

  TaskPState copyWith({
    bool? loadCompleted,
    List<Task>? tasks
  }) => TaskPState(
    loadCompleted: loadCompleted ?? this.loadCompleted,
    tasks: tasks ?? this.tasks,
  );


}


