import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:task_sharing/config/router/router_notifier.dart';
import 'package:task_sharing/features/auth/presentation/screens/auth_screen.dart';
import 'package:task_sharing/features/shared/presentation/screens/new_version_screen.dart';
import 'package:task_sharing/features/tasks/presentation/providers/task_repository_provider.dart';
import 'package:task_sharing/features/tasks/presentation/providers/tasks_provider.dart';
import 'package:task_sharing/features/tasks/presentation/screens/tasks_screen.dart';

import '../../features/auth/presentation/providers/auth_provider.dart';

part 'router.g.dart';

@Riverpod(keepAlive: true)
GoRouter router(RouterRef ref) {
// ignore: avoid_manual_providers_as_generated_provider_dependency
  final routerNotifier = ref.watch(routerNotifierProvider);
  return GoRouter(
    refreshListenable: routerNotifier,
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/auth',
        pageBuilder: (context, state) => _pageBuilder(context, state, const AuthScreen()),
      ),
      GoRoute(
        path: '/',
        pageBuilder: (context, state) => _pageBuilder(context, state, const TasksScreen()),
      ),

      GoRoute(
        path: '/new_version',
        pageBuilder: (context, state) => _pageBuilder(context, state, NewVersionScreen(state.uri.queryParameters['link'] ?? 'ERROR')),
      ),
    ],
    redirect: (context, state) async {
      final authStatus = routerNotifier.authStatus;

      switch(authStatus){
        case AuthStatus.loading: {
          final version = await ref.read(taskRepositoryProvider).getVersion();
          if(version != null){
            final currentVersion = await PackageInfo.fromPlatform();
            if(version.version != currentVersion.version){
              FlutterNativeSplash.remove();
              return Uri(path: '/new_version', queryParameters: {'link':version.link}).toString();
            }
          }
          ref.read(authProvider);
          ref.read(tasksPProvider.notifier).init();
          return '/';
        }
        case AuthStatus.auth:{
          return '/';
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


