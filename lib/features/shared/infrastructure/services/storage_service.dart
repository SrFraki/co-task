// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class StorageService{

//   late SharedPreferences sp;
//   late FlutterSecureStorage se;

//   StorageService() {
//     initialize();
//   }

//   Future<void> initialize() async {
//     sp = await SharedPreferences.getInstance();
//     se = const FlutterSecureStorage(
//       aOptions: AndroidOptions(
//         encryptedSharedPreferences: true
//       )
//     );
//   }

//   Future<void> upload<T>(SKey key, T value, [SMode mode = SMode.normal]) async {
//     if(mode == SMode.secure && T == String){
//       await se.write(key: key.toString(), value: value as String);
//       return;
//     }
    
//     switch (T){
//       case int:
//         await sp.setInt(key.toString(), value as int);
//         break;
//       case String:
//         await sp.setString(key.toString(), value as String);
//         break;
//       case bool:
//         await sp.setBool(key.toString(), value as bool);
//         break;
//       case const (List<String>):
//         await sp.setStringList(key.toString(), value as List<String>);
//         break;
//       case double:
//         await sp.setDouble(key.toString(), value as double);
//         break;
//       default:
//         throw UnimplementedError();
//     }
//   }

//   Future<void> remove(SKey key, [SMode mode = SMode.normal]) async {
//     if(mode == SMode.secure){
//       await se.delete(key: key.toString());
//       return;
//     }
//     await sp.remove(key.toString());
//   }

//   Future<void> removeAllSecure() async {
//     while(true){
//       try {
//         await se.read(key: '');
//         break;
//       } catch (_) {await initialize();}
//     }
//     await se.deleteAll();
//   }

//   Future<T?> read<T>(SKey key, [SMode mode = SMode.normal]) async {
//     if(mode == SMode.secure && T == String){
//       return await se.read(key: key.toString()) as T?;
//     }
//     return sp.get(key.toString()) as T;
//   }

// }

// enum SKey{
//   personalList,
//   accessToken
// }

// enum SMode{
//   secure, normal
// }

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageServ{
  late FlutterSecureStorage _secureStorage;
  late Future<SharedPreferences> _storage;
  final bool secure;

  StorageServ([this.secure = false]){
    if(secure){
      _secureStorage = const FlutterSecureStorage(
        aOptions: AndroidOptions.defaultOptions
      );
    }else{
      _storage = SharedPreferences.getInstance();
    }
  }


  Future<void> delete(String key) async {
    return !secure ? await _storage.then((prefs) => prefs.remove(key)) : await _secureStorage.delete(key: key);
  }


  Future<String?> read(String key) async {
    return !secure ? await _storage.then((prefs) => prefs.getString(key.toString())) : await _secureStorage.read(key: key.toString());
  }

  Future<List<String>?> readJson(String key) async {
    return !secure ? await _storage.then((prefs) async => prefs.getStringList(key)) : null;
  }

  Future<void> deleteAll() async {
    !secure ? await _storage.then((prefs) => prefs.clear()) : await _secureStorage.deleteAll();
  }

  Future<void> write(String key, String value) async {
    !secure ? _storage.then((prefs) => prefs.setString(key, value)) : await _secureStorage.write(key: key.toString(), value: value);
  } 

  Future<void> writeJson(String key, List<String> value) async {
    !secure ? _storage.then((prefs) => prefs.setStringList(key, value)) : null;
  } 
}


enum StorageKey{
  uid, 
  token, 
  refreshToken,
  initialSession
}