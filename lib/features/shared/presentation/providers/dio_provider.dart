import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';
import 'package:task_sharing/features/shared/infrastructure/services/storage_service.dart';

class DioServ{
  StoreServ<String>? _storage;
  late Dio dio;
  String? _token;

  DioServ(){
    _storage = StoreServ<String>(StoreType.auth);
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://task-share-fec6e-default-rtdb.europe-west1.firebasedatabase.app/',
        queryParameters: {
          'auth': _token,
          'Connection':'keep-alive',
          'Keep-Alive':'timeout=10, max=100'
        },
      )
    );

    dio.interceptors.addAll([
      TalkerDioLogger(
        settings: const TalkerDioLoggerSettings(
          printResponseMessage: true,
          printResponseData: true,
          printRequestHeaders: true,
        )
      ),

      InterceptorsWrapper(
        onRequest: _onRequest,
        onError: (error, handler) async {
          if(error.error is SocketException || error.type == DioExceptionType.connectionTimeout){
            //TODO!!
          }
          if(error.response?.statusCode == 401){
            await _storage!.init();
            final flag = await _refreshToken();
            if(!flag) return handler.reject(error);

            await _storage!.write('token', _token);
            final options = error.response!.requestOptions..queryParameters['auth'] = _token;
            final response = await dio.fetch(options);
            return handler.resolve(response);
          }
          return handler.next(error);
        },
      )
    ]);
  }


  Future<void> _onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if(_token == null){
      await _storage!.init();
      _token = _storage!.read('token');
      if(_token == null){
        final flag = await _refreshToken();
        if(!flag) return handler.reject(DioException(requestOptions: options));
      }else{
        // options.headers['Authorization'] = 'Bearer $_token';
        options.queryParameters['auth'] = _token;
        // final resp = await dio.fetch(options);
        return handler.next(options);
      }
      
    }

    if((options.queryParameters['auth'] as String?)?.contains('null') ?? true){
      _token = null;
      return _onRequest(options, handler);
    }
    handler.next(options);
  }


  Future<bool> _refreshToken() async {
    _token = await FirebaseAuth.instance.currentUser?.getIdToken(true);
    if(_token == null){
      await _storage!.deleteAll();
      return false;
    }
    _storage!.write('token', _token);
    return true;
  }
}