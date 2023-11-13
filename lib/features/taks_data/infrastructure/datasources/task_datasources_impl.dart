import 'package:dio/dio.dart';
import 'package:task_sharing/features/shared/infrastructure/services/time_service.dart';
import 'package:task_sharing/features/taks_data/domain/datasources/task_datsource.dart';

import '../../domain/models/group.dart';
import '../../domain/models/task.dart';
import '../../domain/models/tasks_and_uids.dart';

class TaskDatasourceImpl extends TaskDatasource{

  final Dio _dio;

  TaskDatasourceImpl({
    required Dio dio
  }) : _dio = dio;

  @override
  Future<DateTime> getLastWeekMon() async {
    try{
      final response = await _dio.get('last_week_mon.json');
      return TimeService.toDateTimeFormat(response.data);
    }on DioException catch(e){
      print(e);
    }catch (e){
      print(e);
    }
    return DateTime.now();
  }  //1)
  
  @override
  Future<void> updateLastWeekMon(DateTime newMon) async {
    try{
      _dio.patch(
        '.json',
        data: {
          "last_week_mon":TimeService.toStringFormat(newMon)
        }
      );
    }on DioException catch(_){
      // print(e);
    }catch (e){
      print(e);
    }
  }  //1.1)
  
  @override
  Future<TasksAndUids> getTasksAndUids() async {
    try {
      final r1 = await _dio.get('tasks.json');
      final r2 = await _dio.get('groups_uids.json');
      return TasksAndUids(tasks: List<String>.from(r1.data), uids:List<String>.from(r2.data));
    }on DioException catch(_){
      // print(e);
    } catch (e) {
      // print(e);
    }
    return const TasksAndUids();
  }  //2)
  
  @override
  Future<void> updateTasks(List<String> tasks) async {
    try {
      _dio.patch(
        '.json',
        data: {
          'tasks':tasks
        }
      );
    }on DioException catch(_){
      // print(e);
    } catch (e) {
      // print(e);
    }
  }  //2.1)
  
  @override
  Future<void> assignTasks(Group group) async {
    try {
      _dio.patch(
        '.json',
        data: group.toJson()
      );
    }on DioException catch(_){
      // print(e);
    } catch (e) {
      // print(e);
    }
  }  //3)
  
  @override
  Future<void> updateSingleTask(Task task) async {
    try {
      //TODO
    }on DioException catch(_){
      // print(e);
    } catch (e) {
      // print(e);
    }
  } 
  
  @override
  Future<Task> getSingleTask(String uid) async {
    try {
      final response = await _dio.get(
        'group/$uid.json',
      );
      return Task.fromJson(response.data);
    }on DioException catch(_){
      // print(e);
    } catch (e) {
      // print(e);
    }
    return const Task();
  } 
}