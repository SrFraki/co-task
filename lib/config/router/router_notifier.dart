import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_sharing/features/auth/presentation/providers/auth_provider.dart';


final routerNotifierProvider = Provider<RouterNotifier>((ref) {
  Future(() async {
    await ref.read(authProvider.notifier).init();
    // ref.read(tasksPProvider.notifier).init();
  });
  return RouterNotifier(ref.container);
});

class RouterNotifier extends ChangeNotifier {
  
  final ProviderContainer _container;

  AuthStatus _authStatus = AuthStatus.loading;
  set authStatus(AuthStatus value) {
    _authStatus = value;
    notifyListeners();
  }
  AuthStatus get authStatus => _authStatus;

  String _link = '';
  set link(String value){
    _link = value;
    notifyListeners();
  }
  String get link => _link;
  

  RouterNotifier(
    ProviderContainer container
  ) : _container = container {
    _container.listen(authProvider, (prevoius, next) { 
      authStatus = next.status;
      link = next.link;
    });
  }

}