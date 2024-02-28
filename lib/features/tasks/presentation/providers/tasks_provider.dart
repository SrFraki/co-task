import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:task_sharing/features/auth/presentation/providers/auth_provider.dart';
import 'package:task_sharing/features/tasks/domain/models/dbdata.dart';
import 'package:task_sharing/features/tasks/domain/models/task.dart';
import 'package:task_sharing/features/tasks/presentation/providers/task_repository_provider.dart';


part 'tasks_provider.g.dart';
part 'tasks_provider.freezed.dart';

@Riverpod(keepAlive: true)
class TasksP extends _$TasksP {

  int _mutex = 2;
  int _changesRealized = 0;

  @override
  TasksPState build() {
    return TasksPState();
  }




  void toggleIsCompleted(int pos){
    _changesRealized++;
    final value = !state.ownTasks[pos].finalized;
    state.ownTasks[pos].finalized = value;
    state.tasks[state.ownTasks[pos].user].finalized = value;
    ref.notifyListeners();
    ref.read(taskRepositoryProvider).toggleComplete(state.pos, state.ownTasks[pos]);
  }




  void _updateData(DbData data) async {
    final date = DateTime.now();
    final currentWeekMon = DateTime.parse(DateFormat("yyyy-MM-dd").format(date.subtract(Duration(days: date.weekday - 1))));

    final uid = ref.read(authProvider).uid;
    int pos = data.names.indexWhere((e) => e.uid == uid);
    List<Task> ownTasks = [];

    if(currentWeekMon.isAfter(DateTime.fromMillisecondsSinceEpoch(data.week))){
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
        if(i == pos) ownTasks.add(data.tasks[i].copyWith(user: i));
        i++;
      }

      if(_mutex > 0){
        data.week = currentWeekMon.millisecondsSinceEpoch;
        ref.read(taskRepositoryProvider).updateData(data);
      }
    }

    state = state.copyWith(
      names: data.names,
      tasks: data.tasks,
      ownTasks: data.tasks.where((e) => e.user == pos).toList(),
      pos: pos
    );
    
    
  }





  void init() async {
    final DbData? data = await ref.read(taskRepositoryProvider).getData();
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
        @Default(0) int pos
    }) = _TasksPState;
}


