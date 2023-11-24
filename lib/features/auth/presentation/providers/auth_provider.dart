import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:task_sharing/features/shared/infrastructure/services/storage_service.dart';
import 'package:task_sharing/features/shared/presentation/providers/storage_provider.dart';

part 'auth_provider.g.dart';

@Riverpod(keepAlive: true)
class Auth extends _$Auth {
  
  @override
  AuthState build() {
    listenToAuth();
    return AuthState();
  }

  Future<void> listenToAuth() async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if(user == null){
        await ref.read(storagePProvider).removeAllSecure();
        state = state.copyWith(status: AuthStatus.notAuth);
      }else{
        state = state.copyWith(
          status: AuthStatus.auth,
          token: await user.getIdToken(true),
          uid: user.uid,
        );
        await storeInformation();
      }
    });
  }

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
        token: userCredential.credential?.accessToken,
        uid: userCredential.user?.uid,
      );

      await storeInformation();

      await requestPermission();

    } catch (e) {
      await ref.read(storagePProvider).removeAllSecure();
      state = state.copyWith(
        status: AuthStatus.notAuth,
      );
    }

  }

  Future<void> requestPermission() async {
    await Permission.notification.isDenied.then((value) async {
      if(value){
        await Permission.notification.request();
      }
    });
  }

  Future<String?> refreshToken() async {
    String? token = await FirebaseAuth.instance.currentUser?.getIdToken(true);
    state = state.copyWith(token: token);
    await storeInformation();
    return token ??= await refreshToken();
  }


  Future<void> storeInformation() async {
    await ref.read(storagePProvider).upload<String>(SKey.accessToken, state.token, SMode.secure);
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