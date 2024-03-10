import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';

class StoreServ<T>{

  final StoreType _type;
  Box<T>? _box;

  StoreServ(StoreType type) : _type = type;

  Future<void> init() async {
    if(_box != null) return;
    switch(_type){
      case StoreType.auth:
        const ss =  FlutterSecureStorage();
        String? ekey = await ss.read(key: 'ekey');
        if(ekey == null){
          ekey = base64UrlEncode(Hive.generateSecureKey());
          await ss.write(key: 'ekey', value: ekey);
        }
        _box = await Hive.openBox('auth', encryptionCipher: HiveAesCipher(base64Url.decode(ekey)));
        break;
      default:
        _box = await Hive.openBox<T>(_type.toString().replaceAll('StoreType.', ''));
    }
  }

  // static void registerAdapter(){
  //   Hive
  //     ..registerAdapter(SessionAdapter())
  //     ..registerAdapter(ExerciseAdapter())
  //     ..registerAdapter(BestAdapter())
  //     ..registerAdapter(RoutineAdapter());
  //     // ..registerAdapter(ExerciseMetricsAda())
  //     // ..registerAdapter(SessionMetricsAdapter());
  // }

  T? read(String key) => _box!.get(key);
  List<T>? readAll(){
    var a = _box!.values.toList();
    return a;
  }


  Future<void> write(String key, T? value) async {
    if(value == null) return;
    await _box!.put(key, value);
  }
 

  Future<void> delete(String key) async => await _box!.delete(key);
  Future<void> deleteAll() async => await _box!.deleteAll(['token', 'uid']);
  Future<void> deleteAt(int index) async => await _box!.deleteAt(index);

  ValueListenable<Box<T>> getListenable(String key) => _box!.listenable(keys: [key]);
}

enum StoreType{
  auth, tasks
}
