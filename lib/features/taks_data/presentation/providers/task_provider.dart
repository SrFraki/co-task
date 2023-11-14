import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:task_sharing/config/constants/icons_consts.dart';
import 'package:task_sharing/features/auth/presentation/providers/auth_provider.dart';
import 'package:task_sharing/features/shared/infrastructure/services/time_service.dart';
import 'package:task_sharing/features/taks_data/domain/models/group.dart';
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

    final DateTime db = await ref.read(taskRepositoryProvider).getLastWeekMon();
    final String uid = ref.read(authProvider).uid;
    Task? task;

    if(TimeService.compare(db, TimeService.lastWeekMon)){
      ///1) Rotar lista de tareas
      final tasksAndUids = await ref.read(taskRepositoryProvider).getTasksAndUids();
      List<String> tasks = [...tasksAndUids.tasks];
      final firstE = tasks.removeAt(0);
      tasks.add(firstE);
      await ref.read(taskRepositoryProvider).updateTasks(tasks);
      
      ///2) Asignar tareas
      Map<String, Task> g = <String, Task>{};
      for(int i=0; i<tasksAndUids.tasks.length; i++){
        g.addAll({tasksAndUids.uids[i]:Task(
          task: tasksAndUids.tasks[i],
          isCompleted: false
        )});
        if(tasksAndUids.uids[i] == uid){
          task = Task(task: tasksAndUids.tasks[i], isCompleted: false);
        }
      }
      await ref.read(taskRepositoryProvider).assignTasks(Group(group: g));

      ///3) Acutalizar last_week
      await ref.read(taskRepositoryProvider).updateLastWeekMon(TimeService.lastWeekMon);
    }else{
      task = await ref.read(taskRepositoryProvider).getSingleTask(uid);
    }

    // state.task = task ?? const Task(task: 'ERORR 404', isCompleted: true);
    
    state = state.copyWith(
      task: task?.copyWith(icon: IconConstant.getIcon(task.task)) ?? Task(task: 'ERORR 404', isCompleted: true, icon: IconConstant.getIcon()),
      loadCompleted: true
    );
  }

  void toggleComplete(){
    state = state.copyWith(task: state.task.copyWith(isCompleted: !(state.task.isCompleted)));
    final String uid = ref.read(authProvider).uid;
    ref.read(taskRepositoryProvider).updateSingleTask(state.task, uid);
  }
}


class TaskPState{
  bool loadCompleted;
  Task task;

  TaskPState({
    this.loadCompleted = false,
    this.task = const Task()
  });

  TaskPState copyWith({
    bool? loadCompleted,
    Task? task
  }) => TaskPState(
    loadCompleted: loadCompleted ?? this.loadCompleted,
    task: task ?? this.task,
  );


}


