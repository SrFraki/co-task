import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:task_sharing/config/constants/constants.dart';
import 'package:task_sharing/config/router/router_notifier.dart';
import 'package:task_sharing/features/auth/presentation/screens/auth_screen.dart';
import 'package:task_sharing/features/home/presentation/screens/home_screen.dart';
import 'package:task_sharing/features/loading/presentation/screens/loading_screen.dart';
import 'package:task_sharing/features/loading/presentation/screens/new_version_aviable_screen.dart';
import 'package:task_sharing/features/shared/presentation/providers/dio_provider.dart';

import '../../features/auth/presentation/providers/auth_provider.dart';
import '../../features/list/presentation/providers/list_repository_provider.dart';
import '../../features/shared/presentation/providers/storage_provider.dart';
import '../../features/taks_data/presentation/providers/task_provider.dart';
import '../../features/taks_data/presentation/providers/task_repository_provider.dart';

part 'router.g.dart';

@riverpod
GoRouter router(RouterRef ref) {
// ignore: avoid_manual_providers_as_generated_provider_dependency
  final routerNotifier = ref.watch(routerNotifierProvider);
  bool existsNewVersion = false;
  bool loaded = false;
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

      GoRoute(
        path: '/new_version',
        pageBuilder: (context, state) => _pageBuilder(context, state, const NewVersionAviableScreen()),
      ),
    ],
    redirect: (context, state) async {
      final authStatus = routerNotifier.authStatus;
      // final goingTo = state.matchedLocation;
      

      switch(authStatus){
        case AuthStatus.loading: return '/';
        case AuthStatus.auth:{
          if(!loaded){
            await ref.read(storagePProvider).initialize();
            await ref.read(dioServiceProvider.notifier).load();

            //REPOSITORIES
            // ref.read(listRepositoryProvider);
            ref.read(authProvider);
            existsNewVersion = version != await ref.read(taskRepositoryProvider).getVersion();   
            loaded = true;
          }

          if(existsNewVersion) return '/new_version';  
          
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


