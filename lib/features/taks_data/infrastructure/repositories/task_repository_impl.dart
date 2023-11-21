import 'package:task_sharing/features/taks_data/domain/datasources/task_datsource.dart';
import 'package:task_sharing/features/taks_data/domain/repositories/task_repository.dart';

import '../../domain/models/group.dart';
import '../../domain/models/task.dart';
import '../../domain/models/tasks_and_uids.dart';

class TaskRepositoryImpl extends TaskRepository{

  final TaskDatasource _d;

  TaskRepositoryImpl({
    required TaskDatasource datasource
  }) : _d = datasource;

  @override
  Future<String?> getVersion() => _d.getVersion();
  
  @override
  Future<DateTime> getLastWeekMon() => _d.getLastWeekMon();  //1)
  
  @override
  Future<void> updateLastWeekMon(DateTime newMon) => _d.updateLastWeekMon(newMon);  //1.1)
  
  @override
  Future<TasksAndUids> getTasksAndUids() => _d.getTasksAndUids();  //2)
  
  @override
  Future<void> updateTasks(List<String> tasks) => _d.updateTasks(tasks);  //2.1)
  
  @override
  Future<void> assignTasks(Group group) => _d.assignTasks(group);  //3)
  
  @override
  Future<void> updateSingleTask(List<Task> task, String uid) => _d.updateSingleTask(task, uid); 
  
  @override
  Future<List<Task>?> getSingleTask(String uid) => _d.getSingleTask(uid); 

  @override
  Future<Group> getGroup() => _d.getGroup();


}