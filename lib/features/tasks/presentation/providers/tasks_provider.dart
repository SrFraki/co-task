
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
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
    //TODO! if value -> send notifications + remove periodic notification
    //TODO! if !value -> set periodic notification
    ref.notifyListeners();
    ref.read(taskRepositoryProvider).toggleComplete(state.user, state.ownTasks[pagePos]);
  }



  int _getUserPos(List<Name> names){
    int? user = _storage.read('userPos');
    if(user == null){
      final uid = ref.read(authProvider).uid;
      user = names.indexWhere((e) => e.uid == uid);
      if(user != -1) _storage.write('userPos', user);
    }
    return user;
  }


  void _updateData(DbData data) async {
    final current = TimeServ.now; //Current time
    final dayOfChange = data.changeDay; //Day of change

    int user = _getUserPos(data.names);
    List<Task> ownTasks = [], lastWeekTasks = [];

    if(current >= dayOfChange){ 
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
        if(data.tasks[i].user == user) ownTasks.add(data.tasks[i].copyWith(user: i++));
      }

      data.changeDay = TimeServ.nextDayOfChange(dayOfChange);

      final done = await ref.read(taskRepositoryProvider).updateData(data);
      if(!done){
        final newData = await ref.read(taskRepositoryProvider).getData();
        if(newData == null) return; //! ERROR
        return _updateData(newData);
      }

    }else{
      int length = data.tasks.length;
      for(int i=0; i<length; i++){
        Task task = data.tasks[i];
        if(task.user == user){
          ownTasks.add(task.copyWith(user: i));
          if(!task.finalized){
            //TODO! set periodic notification
          }
        }
        lastWeekTasks.add(task.copyWith(
          finalized: task.accumulatedWeeks == 0,
          user: (task.user+1+task.accumulatedWeeks)%length
        ));
      }
    }

    state = state.copyWith(
      names: data.names,
      tasks: data.tasks,
      ownTasks: ownTasks,
      user: user,
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
      if(path == '/') {
        if(_waitingForChangesApplied){
          _waitingForChangesApplied = false;
          _updateData(DbData.fromJson(event['path']));
        }
      } else {
        final int? pos = int.tryParse(path.split('/')[2]);
        if(pos != null && state.tasks[pos].user != state.user){
        // if(state.pos != pos && pos != null){
          updateChanges(
            pos,
            Task.fromJson(event['data']).finalized
          );
        }
      }
    });

    await storeInit;
    _updateData(data);

    FlutterNativeSplash.remove();

  }


  void updateChanges(int pos, bool finalized){
    state.tasks[pos].finalized = finalized;
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
        @Default(0) int user
    }) = _TasksPState;
}


