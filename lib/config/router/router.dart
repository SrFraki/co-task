import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:task_sharing/config/router/router_notifier.dart';
import 'package:task_sharing/features/auth/presentation/screens/auth_screen.dart';
import 'package:task_sharing/features/home/presentation/screens/home_screen.dart';
import 'package:task_sharing/features/loading/presentation/screens/loading_screen.dart';
import 'package:task_sharing/features/shared/presentation/providers/dio_provider.dart';

import '../../features/auth/presentation/providers/auth_provider.dart';
import '../../features/list/presentation/providers/list_repository_provider.dart';
import '../../features/list/presentation/providers/shop_list_provider.dart';
import '../../features/shared/presentation/providers/storage_provider.dart';
import '../../features/taks_data/presentation/providers/task_provider.dart';
import '../../features/taks_data/presentation/providers/task_repository_provider.dart';

part 'router.g.dart';

@riverpod
GoRouter router(RouterRef ref) {
  final routerNotifier = ref.watch(routerNotifierProvider);
  return GoRouter(
    refreshListenable: routerNotifier,
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        pageBuilder: (context, state) => _pageBuilder(context, state, const LoadingScreen()),
      ),

      GoRoute(
        path: '/auth',
        pageBuilder: (context, state) => _pageBuilder(context, state, const AuthScreen()),
      ),

      GoRoute(
        path: '/home',
        pageBuilder: (context, state) => _pageBuilder(context, state, const HomeScreen()),
      ),
    ],
    redirect: (context, state) async {
      final authStatus = routerNotifier.authStatus;
      // final goingTo = state.matchedLocation;
      

      switch(authStatus){
        case AuthStatus.loading: {
          return '/';
        }
        case AuthStatus.auth:{
          await ref.read(dioServiceProvider.notifier).load();
          ref.read(storagePProvider);

          //REPOSITORIES
          ref.read(listRepositoryProvider);
          ref.read(authProvider);
          ref.read(taskRepositoryProvider);
          

          //PROVIDERS LIST
          // ref.read(shopListProvider(ShopListType.personal).notifier).load();
          // ref.read(shopListProvider(ShopListType.shared).notifier).load();
          await ref.read(taskPProvider.notifier).load();

          // OTHER PROVIDERS
          

          return '/home';
        }
        case AuthStatus.notAuth:{
          return '/auth';
        }
      }

    },
  );
}


Page<dynamic> _pageBuilder(BuildContext context, GoRouterState state, Widget child) =>
  CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 300),
    transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(
      opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
      child: child,
    ),
  );


