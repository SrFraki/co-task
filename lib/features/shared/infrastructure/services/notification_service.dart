import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationServ{
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  void init() async {
    //PERMISOS
    flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();
    flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(
      alert: true,
      badge: true,
      sound: true
    );

    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings initializationSettingsDarwin = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true
    );
    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );

    //FIREBASE
    FirebaseMessaging m = FirebaseMessaging.instance;

    /*NotificationSettings settings = */await m.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    // if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    //   print('User granted permission');
    // } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    //   print('User granted provisional permission');
    // } else {
    //   print('User declined or has not accepted permission');
    // }
  }


  Future<void> cancelPeriodicNotification(int id) async => await flutterLocalNotificationsPlugin.cancel(id);

  Future<void> setPeriodicNotificiation(int id) async {
    //LAUNCH PERIODIC NOTIFICATION
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id, 
      'Tareas pendientes', 
      'Comprueba si has marcado tus tareas', 
      tz.TZDateTime(tz.local, 2024, 2, 25, 20, 0, 0, 0, 0),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          '1', 
          'task_reminder',
          channelDescription: 'Reminder to check tasks',
          importance: Importance.max,
          priority: Priority.max,
        ),
        iOS: DarwinNotificationDetails(
          sound: 'default.wav',
          presentAlert: true,
          presentBadge: true,
          presentSound: true
        )
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime
    );
  }


  static void notificationHandler(Future<void> Function(RemoteMessage) handler) => FirebaseMessaging.onBackgroundMessage(handler);

  static void subscribeToTopic(int val) async => await FirebaseMessaging.instance.subscribeToTopic('$val');
  static void unsubscribeToTopic(int val) async => await FirebaseMessaging.instance.unsubscribeFromTopic('$val');



}