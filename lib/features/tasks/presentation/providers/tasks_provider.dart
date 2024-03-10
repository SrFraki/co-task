import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:task_sharing/features/auth/presentation/providers/auth_provider.dart';
import 'package:task_sharing/features/shared/infrastructure/services/storage_service.dart';
import 'package:task_sharing/features/tasks/domain/models/dbdata.dart';
import 'package:task_sharing/features/tasks/domain/models/task.dart';
import 'package:task_sharing/features/tasks/presentation/providers/task_repository_provider.dart';

part 'tasks_provider.g.dart';
part 'tasks_provider.freezed.dart';

@Riverpod(keepAlive: true)
class TasksP extends _$TasksP {

  int _mutex = 2;
  int _changesRealized = 0;
  late StoreServ<int> _storage;

  @override
  TasksPState build() {
    return TasksPState();
  }




  void toggleIsCompleted(int pagePos){
    _changesRealized++;
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


  void _updateData(DbData data) async {
    // final date = tz.TZDateTime.now(tz.getLocation('Europe/España'));
    final date = DateTime.now().toUtc();
    final currentWeekMon = DateTime.parse(DateFormat("yyyy-MM-dd").format(date.subtract(Duration(days: date.weekday-1)))).toUtc();
    // final currentWeekMon = DateTime.parse(DateFormat("yyyy-MM-dd").format(date.subtract(Duration(days: date.weekday - 1))));

    int pos = _getUserPos(data.names);
    List<Task> ownTasks = [], lastWeekTasks = [];

    final dbWeekMon = DateTime.fromMillisecondsSinceEpoch(data.week, isUtc: true);

    if(currentWeekMon.isAfter(dbWeekMon)){
      lastWeekTasks = data.tasks;
      int i=0;
      for(Task task in data.tasks){
        if(task.finalized){
          data.tasks[i] = task.copyWith(
            finalized: false,
            accumulatedWeeks: 0,
            user: (task.user-1-task.accumulatedWeeks)%data.names.length
          );
        }else{
          if(_changesRealized-- <= 0){
            data.tasks[i] = task.copyWith(accumulatedWeeks: ++task.accumulatedWeeks);
            _changesRealized = 0;
          }
        }
        if(data.tasks[i].user == pos) ownTasks.add(data.tasks[i].copyWith(user: i));
        i++;
      }

      if(_mutex > 0){
        data.week = currentWeekMon.millisecondsSinceEpoch;
      }

    }else{
      int i=0;
      for(Task task in data.tasks){
        if(task.user == pos) {
          ownTasks.add(task.copyWith(user: i));
        }
        lastWeekTasks.add(task.copyWith(
          finalized: task.accumulatedWeeks == 0,
          user: (task.user+1+task.accumulatedWeeks)%data.tasks.length
        ));
        i++;
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
    if(data == null) return FlutterNativeSplash.remove();

    ref.read(taskRepositoryProvider).listener().listen((event) {
      final String path = event['path'];
      if(path == '/') {
        _mutex--;
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


