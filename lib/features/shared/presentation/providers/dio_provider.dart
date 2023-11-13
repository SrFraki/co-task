import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';
import 'package:task_sharing/features/auth/presentation/providers/auth_provider.dart';

part 'dio_provider.g.dart';


@Riverpod(keepAlive: true)
class DioService extends _$DioService {

  @override
  Dio build() => Dio();

  Future<void> load() async {

    String token = ref.read(authProvider).token;

    Dio d = Dio(
      BaseOptions(
        baseUrl: 'https://task-share-fec6e-default-rtdb.europe-west1.firebasedatabase.app/',
        queryParameters: {
          'auth':token
        },
        receiveTimeout: const Duration(seconds: 2)
      )
    );

    d.interceptors.addAll([
      TalkerDioLogger(
        settings: const TalkerDioLoggerSettings(
          printResponseMessage: true,
          printResponseData: true,
          printRequestHeaders: true
        )
      ),
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          if(token == ''){
            token = (await ref.read(authProvider.notifier).refreshToken())!;
            options.queryParameters['auth'] = token;
            d.fetch(options);
            return handler.next(options);
          }

          return handler.next(options);
        },
        onError: (e, handler) async {
          if(e.response?.statusCode == 401){
            final options = e.response!.requestOptions;
            token = (await ref.read(authProvider.notifier).refreshToken())!;
            options.queryParameters['auth'] = token;
            final response = await d.fetch(options);
            return handler.resolve(response);
          }
          return handler.next(e);
          // TODO Si el error es de conexion, lanzar error (ns)
        },
      )
    ]);
    state = d;
  }
}