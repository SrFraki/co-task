import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:task_sharing/config/router/router_notifier.dart';
import 'package:task_sharing/features/auth/presentation/screens/auth_screen.dart';
import 'package:task_sharing/features/editor/ui/screens/editor_screen.dart';
import 'package:task_sharing/features/shared/presentation/screens/new_version_screen.dart';
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
        pageBuilder: (context, state) => _pageBuilder(context, state, TasksScreen()),
      ),

      GoRoute(
        path: '/new_version',
        pageBuilder: (context, state) => _pageBuilder(context, state, NewVersionScreen(state.uri.queryParameters['link'] ?? 'ERROR')),
      ),

      GoRoute(
        path: '/editor',
        pageBuilder: (context, state) => _pageBuilder(context, state, EditorScreen()),
      ),
    ],
    redirect: (context, state) async {
      final authStatus = routerNotifier.authStatus;
      final link = routerNotifier.link;

      switch(authStatus){
        case AuthStatus.newVersion:
          return Uri(path: '/new_version', queryParameters: {'link':link}).toString();
        case AuthStatus.loading:
        case AuthStatus.auth: return '/';
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


