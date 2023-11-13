import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:task_sharing/features/shared/presentation/providers/dio_provider.dart';
import 'package:task_sharing/features/taks_data/domain/datasources/task_datsource.dart';
import 'package:task_sharing/features/taks_data/domain/repositories/task_repository.dart';
import 'package:task_sharing/features/taks_data/infrastructure/datasources/task_datasources_impl.dart';
import 'package:task_sharing/features/taks_data/infrastructure/repositories/task_repository_impl.dart';

part 'task_repository_provider.g.dart';

@Riverpod(keepAlive: true)
TaskRepository taskRepository (TaskRepositoryRef ref) {
  final Dio dio = ref.read(dioServiceProvider);
  final TaskDatasource ds = TaskDatasourceImpl(dio: dio);
  return TaskRepositoryImpl(datasource: ds);
}