import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_sharing/config/router/router.dart';

import 'config/theme/theme.dart';
import 'firebase_options.dart';


Future<void> main() async {

  WidgetsBinding wb = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: wb);
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const ProviderScope(child: MainApp()));

  ///TODO Sistema de notificaciones
  ///*   - Notificación semanal (Cada lunes)
  ///   - Un dispositivo envie notis a otros
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final router = ref.watch(routerProvider);

    return ScreenUtilInit(
      designSize: const Size(1440, 3120),
      minTextAdapt: true,
      ensureScreenSize: true,
      splitScreenMode: true,
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: ATheme.themeLight,
        darkTheme: ATheme.themeDark,
        routerConfig: router,
      ),
    );

    // return M
  }
}
