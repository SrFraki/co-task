import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_sharing/config/router/router.dart';
import 'package:task_sharing/features/shared/infrastructure/services/notification_service.dart';
import 'package:task_sharing/features/shared/infrastructure/services/storage_service.dart';

import 'config/theme/theme.dart';
import 'firebase_options.dart';
import 'package:timezone/data/latest_all.dart' as tz;



Future<void> _messageHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
}




Future<void> main() async {

  WidgetsBinding wb = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: wb);
  tz.initializeTimeZones();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await Hive.initFlutter();
  await StorageServ.init();

  //NOTIS
  NotificationServ.notificationHandler(_messageHandler);

  runApp(const ProviderScope(child: MainApp()));
}


class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ATheme.themeLight,
      darkTheme: ATheme.themeDark,
      routerConfig: router,
    );
  }
  
}
