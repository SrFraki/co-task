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
  Future<String?> getVersion() async{
    try{
      return (await _dio.get('version.json')).data;
    }catch (_){}
    return null;
  }

  @override
  Future<DateTime> getLastWeekMon() async {
    try{
      final response = await _dio.get('last_week_mon.json');
      return TimeService.toDateTimeFormat(response.data);
    }on DioException catch(_){
      // print(e);
    }catch (e){
      // print(e);
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
      // print(e);
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
  Future<void> updateSingleTask(List<Task> task, String uid) async {
    try {
      Map<String, dynamic> data = {};
      for(int i=0; i<task.length; i++){
        data['$i'] = task[i].toJson();
      }
      _dio.patch(
        'group/$uid.json',
        data: data
      );
    }on DioException catch(_){
      // print(e);
    } catch (e) {
      // print(e);
    }
  } 
  
  @override
  Future<List<Task>?> getSingleTask(String uid) async {
    try {
      final response = await _dio.get(
        'group/$uid.json',
      );
      List<Task> result = [];
      for(var e in response.data){
        result.add(Task.fromJson(e));
      }
      if(result.isEmpty) return null;
      return result;
    }on DioException catch(_){
      // print(e);
    } catch (e) {
      // print(e);
    }
    return null;
  } 


  @override
  Future<Group> getGroup() async {
    try {
      final response = await _dio.get(
        'group.json',
      );

      return Group.fromJson(response.data);
    }on DioException catch(_){
      // print(e);
    } catch (e) {
      // print(e);
    }

    return Group(group: {});
  }
}