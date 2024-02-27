import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:task_sharing/features/tasks/domain/models/dbdata.dart';
import 'package:task_sharing/features/tasks/domain/models/task.dart';
import 'package:task_sharing/features/tasks/domain/models/version.dart';

class TaskDatasourceImpl {

  final Dio _dio;

  TaskDatasourceImpl({
    required Dio dio
  }) : _dio = dio;


  /// int user -> Corresponde a la posicion propia dentro de la lista [names]
  /// Task task -> Corresponde a la [task] que hemos modificado, teniendo en cuenta que su campo [user] es la posición en DB
  Future<void> toggleComplete(int user, Task task) async {
    try {
      await _dio.patch(
        '/tasks/${task.user}.json',
        data: task.copyWith(user: user).toJson()
      );
    } catch (e) {
      log(e.toString());
      log('$user');
    }
  }


  Future<bool> updateData(DbData data) async {
    try {
      await _dio.patch(
        '/.json',
        data: data.toJson()
      );
      return true;
    } catch (_) {
      return false;
    }
  } 


  Future<Version?> getVersion() async {
    try {
      return Version.fromJson((await _dio.get('/version.json')).data);
    } catch (_) {return null;}
  }


  Future<DbData?> getData([String? currentDate]) async {
    try {
      final resp = await _dio.get('/.json');
      return DbData.fromJson(resp.data);
    } catch (e) {
      log(e.toString());
      return null;
    }
  }


  Stream<Map<String, dynamic>> listener() async*{
    try {
      final resp = await _dio.get<ResponseBody>(
        '.json',
        options: Options(
          headers: {
            'Accept':'text/event-stream'
          },
          responseType: ResponseType.stream
        )
      );

      await for(Uint8List event in resp.data!.stream){
        // final data = json.decode(utf8.decode(event).split('data: ').last);
        // if(data == null) continue;
        // log(data.toString());
        // if(data['path'] == '/') continue;

        // final listKey = (data['path'] as String).split('/')..removeAt(0);
        // log(data.toString());
        // if(listKey.length > 1){
        //   yield (int.parse(listKey.first), int.parse(listKey.last), data['data']);
        // }else{
        //   final dataMap = data['data'] as Map<String, dynamic>;
        //   yield (int.parse(listKey.last), int.parse(dataMap.keys.first), bool.parse(dataMap.values.first));
        // }

        final Map<String, dynamic>? data = json.decode(utf8.decode(event).split('data: ').last);
        if(data == null) continue;
        log(data.toString());
        yield data;
      }
    } catch (_) {}
  }

}