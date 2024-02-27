import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:task_sharing/features/shared/infrastructure/services/storage_service.dart';
import 'package:task_sharing/features/tasks/presentation/providers/tasks_provider.dart';

part 'auth_provider.g.dart';

@Riverpod(keepAlive: true)
class Auth extends _$Auth {

// ignore: avoid_public_notifier_properties
  late StoreServ storage;
  
  @override
  AuthState build() {
    storage = StoreServ<String>(StoreType.auth);
    storage.init().then((_) async {
      await listenToAuth();
      listen();
    });
    return AuthState();
  }

  Future<void> listenToAuth() async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if(user == null){
        if(state.status != AuthStatus.notAuth) logout();
      }else{
        state = state.copyWith(
          status: AuthStatus.auth,
          token: await user.getIdToken(true),
          uid: user.uid,
        );
        storeInformation();
      }
    });
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
    } catch (_) {
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
    FirebaseAuth.instance.signOut();
    state = state.copyWith(status: AuthStatus.notAuth);
    FlutterNativeSplash.remove();
  }

}


class AuthState{
  AuthStatus status;
  String token;
  String uid;

  AuthState({
    this.status = AuthStatus.loading,
    this.token = '',
    this.uid = '',
  });

  AuthState copyWith({
    AuthStatus? status,
    String? token,
    String? uid,
    AuthCredential? credential
  }) => AuthState(
    status: status ?? this.status,
    token: token ?? this.token,
    uid: uid ?? this.uid,
  );
}


enum AuthStatus{
  loading,
  auth,
  notAuth
}