import 'package:task_sharing/features/list/domain/datasources/list_datasource.dart';
import 'package:task_sharing/features/list/domain/repositories/list_repository.dart';
import 'package:task_sharing/features/list/presentation/providers/shop_list_provider.dart';
import 'package:task_sharing/features/shared/infrastructure/services/storage_service.dart';



class ListRepositoryImpl extends ListRepository{

  final ListDatasource _ds;

  ListRepositoryImpl(ListDatasource datasource) : _ds = datasource;

  @override
  Future<List<ShopItem>> getList([SKey? storageKey, String? token, String? groupId]) => _ds.getList(storageKey, token, groupId);

  @override
  Future<void> updateList(List<ShopItem> list, [SKey? storageKey, String? token]) => _ds.updateList(list, storageKey, token);

}

