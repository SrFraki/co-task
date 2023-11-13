import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService{

  late SharedPreferences sp;
  late FlutterSecureStorage se;

  StorageService() {
    initialize();
  }

  Future<void> initialize() async {
    sp = await SharedPreferences.getInstance();
    se = const FlutterSecureStorage(
      aOptions: AndroidOptions(
        encryptedSharedPreferences: true
      )
    );
  }

  Future<void> upload<T>(SKey key, T value, [SMode mode = SMode.normal]) async {
    if(mode == SMode.secure && T == String){
      await se.write(key: key.toString(), value: value as String);
      return;
    }
    
    switch (T){
      case int:
        await sp.setInt(key.toString(), value as int);
        break;
      case String:
        await sp.setString(key.toString(), value as String);
        break;
      case bool:
        await sp.setBool(key.toString(), value as bool);
        break;
      case const (List<String>):
        await sp.setStringList(key.toString(), value as List<String>);
        break;
      case double:
        await sp.setDouble(key.toString(), value as double);
        break;
      default:
        throw UnimplementedError();
    }
  }

  Future<void> remove(SKey key, [SMode mode = SMode.normal]) async {
    if(mode == SMode.secure){
      await se.delete(key: key.toString());
      return;
    }
    await sp.remove(key.toString());
  }

  Future<T?> read<T>(SKey key, [SMode mode = SMode.normal]) async {
    if(mode == SMode.secure && T == String){
      return await se.read(key: key.toString()) as T?;
    }
    return sp.get(key.toString()) as T;
  }

}

enum SKey{
  personalList,
  accessToken
}

enum SMode{
  secure, normal
}