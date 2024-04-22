
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:task_sharing/features/auth/presentation/providers/auth_provider.dart';
import 'package:task_sharing/features/shared/infrastructure/services/notification_service.dart';
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
  late Box<int> _storage;
  late NotificationServ _notis;

  @override
  TasksPState build() {
    _notis = NotificationServ()..init();
    return TasksPState();
  }

  // ignore: slash_for_doc_comments
  /**
   * NotificationServ()
    ..init()
    ..setPeriodicNotificiation();
   */


  Future<void> toggleIsCompleted(int pagePos) async {
    final value = !state.ownTasks[pagePos].finalized;
    state.ownTasks[pagePos].finalized = value;
    if(value){
      _notis.cancelPeriodicNotification(pagePos);

      
      ref.read(taskRepositoryProvider).sendNotifications(
        '${state.names[state.user].name} ha completado su tarea: ${state.ownTasks[pagePos].task}', 
        // state.names,
      );
    }else{
      _notis.setPeriodicNotificiation(pagePos);
    }
    ref.notifyListeners();
    ref.read(taskRepositoryProvider).toggleComplete(state.user, state.ownTasks[pagePos]);
  }



  int _getUserPos(List<Name> names){
    int? user = _storage.get('userPos');
    if(user == null){
      final uid = ref.read(authProvider).uid;
      user = names.indexWhere((e) => e.uid == uid);
      if(user != -1) _storage.put('userPos', user);
    }

    // Future(() async {
    //   String? token = await FirebaseMessaging.instance.getToken();
    //   if(token != null && names[user!].token != token){
    //     ref.read(taskRepositoryProvider).updateNotificationToken(user, token);
    //     names[user].token = token;
    //   }
    // });

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
        if(data.tasks[i].user == user) ownTasks.add(data.tasks[i].copyWith(user: i));
        i++;
      }

      data.changeDay = TimeServ.nextDayOfChange(dayOfChange);

      final done = await ref.read(taskRepositoryProvider).updateData(data);
      if(!done){
        final newData = await ref.read(taskRepositoryProvider).getData();
        if(newData == null) return; //! ERROR
        return _updateData(newData);
      }

    }else{
      int ownTaskIndex = 0;
      int length = data.tasks.length;
      for(int i=0; i<length; i++){
        Task task = data.tasks[i];
        if(task.user == user){
          ownTasks.add(task.copyWith(user: i));
          if(!task.finalized) _notis.setPeriodicNotificiation(ownTaskIndex++);
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
    _storage = StorageServ.getBox<int>(StorageType.tasks);
    
    if(data == null) return FlutterNativeSplash.remove(); //TODO!! Mostrar error de conexion o 404

    ref.read(taskRepositoryProvider).listener().listen((event) {
      final String path = event['path'];
      if(path == '/') {
        if(_waitingForChangesApplied){
          _waitingForChangesApplied = false;
          _updateData(DbData.fromJson(event['path']));
        }
      } else {
        List<String> p = path.split('/');
        if(p.firstOrNull == 'tasks'){
          final int? pos = int.tryParse(p[2]);
          if(pos != null && state.tasks[pos].user != state.user){
          // if(state.pos != pos && pos != null){
            updateChanges(
              pos,
              Task.fromJson(event['data']).finalized
            );
          }
        }
      }
    });

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


