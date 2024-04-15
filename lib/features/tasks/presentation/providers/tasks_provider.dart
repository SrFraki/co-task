import 'dart:html';

import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:task_sharing/features/auth/presentation/providers/auth_provider.dart';
import 'package:task_sharing/features/shared/infrastructure/services/storage_service.dart';
import 'package:task_sharing/features/shared/infrastructure/services/time_service.dart';
import 'package:task_sharing/features/tasks/domain/models/dbdata.dart';
import 'package:task_sharing/features/tasks/domain/models/task.dart';
import 'package:task_sharing/features/tasks/presentation/providers/task_repository_provider.dart';

part 'tasks_provider.g.dart';
part 'tasks_provider.freezed.dart';

@Riverpod(keepAlive: true)
class TasksP extends _$TasksP {

  bool _waitingForChangesApplied = false;
  late StoreServ<int> _storage;

  @override
  TasksPState build() => TasksPState();




  void toggleIsCompleted(int pagePos){
    final value = !state.ownTasks[pagePos].finalized;
    state.ownTasks[pagePos].finalized = value;
    state.tasks[state.ownTasks[pagePos].user].finalized = value;
    ref.notifyListeners();
    ref.read(taskRepositoryProvider).toggleComplete(state.pos, state.ownTasks[pagePos]);
  }



  int _getUserPos(List<Name> names){
    int? pos = _storage.read('userPos');
    if(pos == null){
      final uid = ref.read(authProvider).uid;
      pos = names.indexWhere((e) => e.uid == uid);
      if(pos != -1) _storage.write('userPos', pos);
    }
    return pos;
  }


  _updateData(DbData data) async {
    final current = TimeServ.now; //Current time
    final dayOfChange = data.week; //Day of change

    int pos = _getUserPos(data.names);
    List<Task> ownTasks = [], lastWeekTasks = [];

    if(current >= dayOfChange){ //Ha pasado el dia de cambio
      ///TODO! Lanzar señal -> Solicitar peticion de cambios
      ///db -> dayOfChange = -1
      ///Si ya estaba en -1 -> Esperar los cambios
      ///   Si tardan mas de 10s -> Realizar cambios
      bool? changeRequestResp = await ref.read(taskRepositoryProvider).changeRequest();
      if(changeRequestResp == null) return; //! ERROR
      if(!changeRequestResp){
        _waitingForChangesApplied = true;
        return;
      }

      lastWeekTasks = data.tasks;
      int i=0;
      for(Task task in data.tasks){
        if(task.finalized){
          data.tasks[i] = task.copyWith(
            finalized: false,
            accumulatedWeeks: 0,
            user: (task.user-1-task.accumulatedWeeks)%data.names.length
          );
        }
        if(data.tasks[i].user == pos) ownTasks.add(data.tasks[i].copyWith(user: i));
        i++;
      }

      data.week = TimeServ.nextDayOfChange(dayOfChange);

      final done = await ref.read(taskRepositoryProvider).updateData(data);
      if(!done){
        final newData = await ref.read(taskRepositoryProvider).getData();
        if(newData == null) return; //! ERROR
        return _updateData(newData);
      }
      ///TODO! Lanzar señal -> Finalizar cambios
      ///Si dbDayOfChange != -1 -> Anular cambios y solicitar datos de nuevo
      ///db -> dayOfChange = nextDayOfChange + Realizar cambios

    }else{
      for(int i=0; i<data.tasks.length; i++){
        Task task = data.tasks[i];
        if(task.user == pos){
          ownTasks.add(task.copyWith(user: i));
          data.tasks.removeAt(i);
        }
        lastWeekTasks.add(task.copyWith(
          finalized: task.accumulatedWeeks == 0,
          user: (task.user+1+task.accumulatedWeeks)%data.tasks.length
        ));
      }
    }

    state = state.copyWith(
      names: data.names,
      tasks: data.tasks,
      ownTasks: ownTasks,
      pos: pos,
      lastWeekTasks: lastWeekTasks
    );
  }





  Future<void> init() async {
    final DbData? data = await ref.read(taskRepositoryProvider).getData();
    _storage = StoreServ<int>(StoreType.tasks);
    final storeInit = _storage.init();
    if(data == null) return FlutterNativeSplash.remove(); //TODO!! Mostrar error de conexion o 404

    ref.read(taskRepositoryProvider).listener().listen((event) {
      final String path = event['path'];
      if(path == '/' && _waitingForChangesApplied) {
        _waitingForChangesApplied = false;
        _updateData(DbData.fromJson(event['path']));
      } else {
        final int pos = int.tryParse(path.split('/')[2]) ?? -1;
        if(state.pos != pos){
          updateChanges(
            pos,
            Task.fromJson(event['data'])
          );
        }
      }
    });

    await storeInit;
    _updateData(data);

    FlutterNativeSplash.remove();

  }


  void updateChanges(int pos, Task task){
    state.tasks[pos] = task;
    ref.notifyListeners();
  }


}


@unfreezed
class TasksPState with _$TasksPState {
    factory TasksPState({
        @Default([]) List<Name> names,
        @Default([]) List<Task> tasks,
        @Default([]) List<Task> ownTasks,
        @Default([]) List<Task> lastWeekTasks,
        @Default(0) int pos
    }) = _TasksPState;
}


