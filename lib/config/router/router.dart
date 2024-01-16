
import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:task_sharing/config/constants/constants.dart';
import 'package:task_sharing/config/router/router_notifier.dart';
import 'package:task_sharing/features/auth/presentation/screens/auth_screen.dart';
import 'package:task_sharing/features/shared/presentation/providers/dio_provider.dart';
import 'package:task_sharing/features/shared/presentation/screens/new_version_screen.dart';
import 'package:task_sharing/features/tasks/presentation/providers/task_repository_provider.dart';
import 'package:task_sharing/features/tasks/presentation/providers/tasks_provider.dart';
import 'package:task_sharing/features/tasks/presentation/screens/tasks_screen.dart';

import '../../features/auth/presentation/providers/auth_provider.dart';

part 'router.g.dart';

@riverpod
GoRouter router(RouterRef ref) {
// ignore: avoid_manual_providers_as_generated_provider_dependency
  final routerNotifier = ref.watch(routerNotifierProvider);
  bool loaded = false;
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
        case AuthStatus.loading: return '/';
        case AuthStatus.auth:{
          if(!loaded){
            await ref.read(dioServiceProvider.notifier).load();

            final versionData = await ref.read(taskRepositoryProvider).getVersion();
            if(versionData != null){
              final versionList = versionData.split('-*-');
              if(versionList.first != version){
                FlutterNativeSplash.remove();
                return Uri(path: '/new_version', queryParameters: {'link':versionList.last}).toString();
                // return '/new_version/${versionList.last}';
              }
            }
            
            ref.read(tasksPProvider.notifier).init();
            ref.read(authProvider);
            loaded = true;
          }
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


