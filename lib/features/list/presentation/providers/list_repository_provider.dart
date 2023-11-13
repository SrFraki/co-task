import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:task_sharing/features/shared/presentation/providers/dio_provider.dart';
import '../../domain/datasources/list_datasource.dart';
import '../../domain/repositories/list_repository.dart';
import '../../infrastructure/datasoruces/list_datasource_impl.dart';
import '../../infrastructure/repositories/list_repository_impl.dart';

part 'list_repository_provider.g.dart';

@Riverpod(keepAlive: true)
ListRepository listRepository (ListRepositoryRef ref) {
  final dio = ref.read(dioServiceProvider);
  final ListDatasource ds = ListDatasourceImpl(dio);
  return ListRepositoryImpl(ds);
}

