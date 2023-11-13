import '../models/group.dart';
import '../models/task.dart';
import '../models/tasks_and_uids.dart';

abstract class TaskRepository{
  Future<DateTime> getLastWeekMon(); //1)
  Future<void> updateLastWeekMon(DateTime newMon); //1.1)
  Future<TasksAndUids> getTasksAndUids(); //2)
  Future<void> updateTasks(List<String> tasks); //2.1)
  Future<void> assignTasks(Group group); //3)

  
  Future<void> updateSingleTask(Task task);
  Future<Task> getSingleTask(String uid);
}