import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:task_sharing/features/tasks/domain/models/tasks_data_model.dart';

class TaskDatasourceImpl {

  final Dio _dio;

  TaskDatasourceImpl({
    required Dio dio
  }) : _dio = dio;

  Future<void> toggleComplete(bool value, int listPos, int pos) async {
    try {
      await _dio.patch(
        '/completed_tasks/$listPos.json',
        data: {'$pos':value.toString()}
      );
    } catch (e) {
      log(e.toString());
      log('$pos');
    }
  }


  Future<String?> getVersion() async {
    try {
      return (await _dio.get('/version.json')).data as String;
    } catch (_) {return null;}
  }


  Future<TasksData?> getData([String? currentDate]) async {
    try {
      final resp = await _dio.get('https://gettasks-wdo2h3mcaa-uc.a.run.app');
      return TasksData.fromJson(resp.data);
    } catch (e) {
      log(e.toString());
      return null;
    }
  }


  Stream<(int, int, bool)> listener() async*{
    try {
      final resp = await _dio.get<ResponseBody>(
        '/completed_tasks.json',
        options: Options(
          headers: {
            'Accept':'text/event-stream'
          },
          responseType: ResponseType.stream
        )
      );

      await for(Uint8List event in resp.data!.stream){
        final data = json.decode(utf8.decode(event).split('data: ').last);
        if(data == null) continue;
        if(data['path'] == '/') continue;

        final listKey = (data['path'] as String).split('/')..removeAt(0);
        if(listKey.length > 1){
          yield (int.parse(listKey.first), int.parse(listKey.last), data['data']);
        }else{
          final dataMap = data['data'] as Map<String, dynamic>;
          yield (int.parse(listKey.last), int.parse(dataMap.keys.first), bool.parse(dataMap.values.first));
        }
      }
    } catch (_) {}
  }

}