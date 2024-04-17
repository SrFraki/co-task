import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';
import 'package:task_sharing/features/tasks/domain/models/dbdata.dart';
import 'package:task_sharing/features/tasks/domain/models/task.dart';
import 'package:task_sharing/features/tasks/domain/models/version.dart';

import 'package:googleapis_auth/auth_io.dart' as auth;


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
      int changeDay = (await _dio.get('/changeDay.json')).data;
      if(changeDay != -1) return false;

      await _dio.patch(
        '/.json',
        data: data.toJson()
      );
      return true;
    } catch (_) {
      return false;
    }
  } 


  Future<bool?> changeRequest() async {
    try{
      final resp = (await _dio.get('/changeDay.json'));
      int changeDay = resp.data;
      if(changeDay < 0) return false;

      await _dio.patch('/.json', data: {'changeDay': -1});
      return true;
    }catch(e){
      log(e.toString());
      return null;
    }
  }



  Future<Version?> getVersion() async {
    try {
      return Version.fromJson((await _dio.get('/version.json')).data);
    } catch (_) {return null;}
  }


  Future<DbData?> getData([String? currentDate]) async {
    try {
      final namesReq = _dio.get('/names.json');
      final tasksReq = _dio.get('/tasks.json');
      final weekReq = _dio.get('/changeDay.json');

      return DbData.fromJson({
        'names': (await namesReq).data,
        'tasks': (await tasksReq).data,
        'changeDay': (await weekReq).data
      });
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
        final Map<String, dynamic>? data = json.decode(utf8.decode(event).split('data: ').last);
        if(data == null) continue;
        log(data.toString());
        yield data;
      }
    } catch (_) {}
  }


  // void updateNotificationToken(int user, String token) async {
  //   try{
  //     await _dio.patch('/names/$user.json', data: {'token': token});
  //   }catch(e){log(e.toString());}
  // }


  Future<void> sendNotifications(String message, /**List<Name> names, String? token */) async {
    final jsonCredentials = await rootBundle.loadString('assets/data/service-account.json');
    final creeds = auth.ServiceAccountCredentials.fromJson(jsonCredentials);

    final client = await auth.clientViaServiceAccount(
      creeds, 
      ['https://www.googleapis.com/auth/cloud-platform'],
    );

    try{
      await client.post(
        Uri.parse('https://fcm.googleapis.com/v1/projects/1084759771003/messages:send'),
        headers: {
          'content-type': 'application/json',
        },
        body: jsonEncode({
            'message': {
              // 'token': name.token,
              'topic':'0', ///TODO Substituir por [id] del grupo
              'notification': {'title': 'Tarea completada', 'body': message}
            },
          }
        )
      );

    }catch(e){log(e.toString());}

    // try{

    //     await client.post(
    //       Uri.parse('https://fcm.googleapis.com/v1/projects/1084759771003/messages:send'),
    //       headers: {
    //         'content-type': 'application/json',
    //       },
    //       body: jsonEncode({
    //           'message': {
    //             // 'token': name.token,
    //             'topic':'0',
    //             'notification': {'title': 'PRUEBA', 'body': message}
    //           },
    //         }
    //       )
    //     );

    //   }catch(e){log(e.toString());}

  }


}