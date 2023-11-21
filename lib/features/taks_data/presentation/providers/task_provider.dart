import 'dart:async';

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
      ///1) ROTAR LISTA DE TAREAS
      TasksAndUids tasksAndUids = await ref.read(taskRepositoryProvider).getTasksAndUids();
      List<String> tasks = [...tasksAndUids.tasks];
      String firstE = tasks.removeAt(0);
      tasks.add(firstE);
      await ref.read(taskRepositoryProvider).updateTasks(tasks);
      
      ///2) COMPROBAR NO COMPLETADOS
      final lastWeekGroup = await ref.read(taskRepositoryProvider).getGroup();
      Map<String, List<Task>> uidsPunished = {};
      List<String> notCompletedTasks = [];
      lastWeekGroup.group.forEach((key, value) { 
        List<Task> uncompletedTasks = [];
        for (var element in value) { if(!element.isCompleted) uncompletedTasks.add(element); }
        if(uncompletedTasks.isNotEmpty){
          uidsPunished[key] = uncompletedTasks;
          notCompletedTasks = [...notCompletedTasks, ...uncompletedTasks.map((e) => e.task)]; 
        }
      });
      

      bool flag = false;
      int cont = 0;
      uidsPunished.forEach((key, value) { 
        if(value.length == tasksAndUids.tasks.length) flag = true;
        if(value.length == 1) cont += value.length;
      });

      if(cont == tasksAndUids.tasks.length) flag = true;

      if(!flag){
        ///3) ASIGNAR TAREAS
        Map<String, List<Task>> g = <String, List<Task>>{};
        for(int i=0; i<tasksAndUids.tasks.length; i++){
          g[tasksAndUids.uids[i]] = [Task(
            task: tasks[i],
            isCompleted: tasks[i] == 'COMPRAR' //TODO
          )];
        }

        ///4) Quitar tareas no realizadas
        g.forEach((key, value) {
          if(notCompletedTasks.contains(value.first.task)){
            g[key]?.removeAt(0);
          }
        });

        ///5) Añadir tareas no realizadas
        g.forEach((key, value) {
          g[key] = [...value, ...(uidsPunished[key] ?? [])];
        });
        
        task = g[uid];
        ///6) PETICION HTTP 
        await ref.read(taskRepositoryProvider).assignTasks(Group(group: g));

      }
      ///6) Acutalizar last_week
      await ref.read(taskRepositoryProvider).updateLastWeekMon(TimeService.lastWeekMon);
    }else{
      task = await ref.read(taskRepositoryProvider).getSingleTask(uid);
    }

    for (var element in task ?? []) {
      element.icon = IconConstant.getIcon(element.task);
    }
    if(task == null || task.isEmpty) task = [Task(task: "VACACIONES", isCompleted: true, icon: IconConstant.getIcon("VACACIONES"))]; 
    state = state.copyWith(tasks: task);
  }

  void toggleComplete(int index){
    if(state.tasks.first.task == 'VACACIONES') return;
    if(state.tasks.first.task == 'COMPRAR') return; //TODO
    final String uid = ref.read(authProvider).uid;
    final auxTasks = state.tasks;
    auxTasks[index].isCompleted = !(auxTasks[index].isCompleted);
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


