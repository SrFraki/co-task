import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:task_sharing/features/shared/presentation/providers/dio_provider.dart';
import 'package:task_sharing/features/tasks/infrastructure/datasources/task_datasources_impl.dart';

part 'task_repository_provider.g.dart';

@riverpod
TaskDatasourceImpl taskRepository (TaskRepositoryRef ref) {
  Dio dio = ref.read(dioServiceProvider);
  return TaskDatasourceImpl(dio: dio);
}