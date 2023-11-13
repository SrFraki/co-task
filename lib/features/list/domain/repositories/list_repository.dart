import '../../../shared/infrastructure/services/storage_service.dart';
import '../../presentation/providers/shop_list_provider.dart';

abstract class ListRepository{
  Future<void> updateList(List<ShopItem> list, [SKey? storageKey, String? token]);
  Future<List<ShopItem>> getList([SKey? storageKey, String? token, String? groupId]);
}