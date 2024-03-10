import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:task_sharing/features/shared/infrastructure/services/storage_service.dart';
import 'package:task_sharing/features/tasks/domain/models/version.dart';
import 'package:task_sharing/features/tasks/presentation/providers/task_repository_provider.dart';
import 'package:task_sharing/features/tasks/presentation/providers/tasks_provider.dart';

part 'auth_provider.g.dart';

@Riverpod(keepAlive: true)
class Auth extends _$Auth {

// ignore: avoid_public_notifier_properties
  late StoreServ<String> storage;
  
  @override
  AuthState build() {
    storage = StoreServ<String>(StoreType.auth);
    return AuthState();
  }

  Future<void> init() async {
    await storage.init();
    
    String? token = storage.read('token');
    String? uid = storage.read('uid');
    User? user = FirebaseAuth.instance.currentUser;

    if(token == null || uid == null || user == null){
      logout();
    }else{
      state = state.copyWith(
        status: AuthStatus.auth,
        token: await user.getIdToken(),
        uid: user.uid
      );

      await storeInformation();
      _checkVersion();
      ref.read(tasksPProvider.notifier).init();
    }
    
    listen();
  }


  Future<void> _checkVersion() async {
    Version? version = await ref.read(taskRepositoryProvider).getVersion();
    if(version != null){
      PackageInfo currentVersion = await PackageInfo.fromPlatform();
      if(version.version != currentVersion.version){
        ref.invalidate(tasksPProvider);
        state = state.copyWith(
          status: AuthStatus.newVersion,
          link: version.link
        );
        FlutterNativeSplash.remove();
      }
    }else{
      logout();
    }
  }


  void listen() => ValueListenableBuilder<Box>(
    valueListenable: storage.getListenable('token'),
    builder: (context, box, widget) {
      if(box.get('token') == null){
        logout();
      }
      return const SizedBox();
    },
  );


  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken
      );

      final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

      state = state.copyWith(
        status: AuthStatus.auth,
        token: userCredential.credential?.accessToken ?? '',
        uid: userCredential.user?.uid,
      );

      await storeInformation();

      // await requestPermission();
      ref.read(tasksPProvider.notifier).init();
    } catch (e) {
      log(e.toString());
      logout();
    }

  }

  Future<String?> refreshToken() async {
    String? token = await FirebaseAuth.instance.currentUser?.getIdToken(true);
    state = state.copyWith(token: token);
    await storeInformation();
    return token ?? await refreshToken();
  }


  Future<void> storeInformation() async {
    storage.write('token', state.token);
    storage.write('uid', state.uid);
  }

  Future<void> logout() async {
    await storage.deleteAll();
    await FirebaseAuth.instance.signOut();
    state = state.copyWith(status: AuthStatus.notAuth);
    FlutterNativeSplash.remove();
  }

}


class AuthState{
  AuthStatus status;
  String token;
  String uid;
  String link;

  AuthState({
    this.status = AuthStatus.loading,
    this.token = '',
    this.uid = '',
    this.link = ''
  });

  AuthState copyWith({
    AuthStatus? status,
    String? token,
    String? uid,
    String? link,
    AuthCredential? credential
  }) => AuthState(
    status: status ?? this.status,
    token: token ?? this.token,
    uid: uid ?? this.uid,
    link: link ?? this.link
  );
}


enum AuthStatus{
  loading,
  auth,
  notAuth,
  newVersion
}