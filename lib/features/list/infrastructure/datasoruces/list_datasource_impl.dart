import 'package:dio/dio.dart';
import 'package:task_sharing/features/list/domain/datasources/list_datasource.dart';
import 'package:task_sharing/features/list/presentation/providers/shop_list_provider.dart';
import 'package:task_sharing/features/shared/infrastructure/services/storage_service.dart';

class ListDatasourceImpl extends ListDatasource{

  final Dio _dio;

  ListDatasourceImpl(Dio dio) : _dio = dio;

  @override
  Future<List<ShopItem>> getList([SKey? storageKey, String? token, String? groupId]) async {

    switch(storageKey){
      case SKey.personalList:{
        final storage = StorageService();
        final List<String>? data  =  await storage.read(SKey.personalList);

        if(data == null) return [];
        return ShopListState.toShopItem(data);
      }
      default: {
        
      }
    }

    throw UnimplementedError();
  }

  @override
  Future<void> updateList(List<ShopItem> list, [SKey? storageKey, String? token]) {
    throw UnimplementedError();
  }

}