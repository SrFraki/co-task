import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:task_sharing/features/shared/infrastructure/services/storage_service.dart';

part 'storage_provider.g.dart';

@Riverpod(keepAlive: true)
StorageService storageP (StoragePRef ref) {
  return StorageService();
}