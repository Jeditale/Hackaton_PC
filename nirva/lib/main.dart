import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nirva/pages/getpremium_page.dart';
import 'package:nirva/services/notification_services.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationServices.init();
  tz.initializeTimeZones();
  

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  var androidSettings = AndroidInitializationSettings('app_icon');
  var initializationSettings = InitializationSettings(
    android: androidSettings,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  // Request notification permissions for Android 13+
  await requestNotificationPermissions();
  await Firebase.initializeApp();

  runApp(MyApp()); // Wrap with MaterialApp here
}

Future<void> requestNotificationPermissions() async {
  final PermissionStatus permissionStatus = await Permission.notification.status;

  if (permissionStatus.isDenied || permissionStatus.isPermanentlyDenied) {
    final PermissionStatus status = await Permission.notification.request();
    if (status.isDenied) {
      print("Notification permission denied");
    } else if (status.isGranted) {
      print("Notification permission granted");
    }
  } else {
    print("Notification permission already granted");
  }
}

// Wrapping MainMenu with MaterialApp to resolve the Directionality issue
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Optional: Hide the debug banner
      home: GetPremiumPage(), 
    );
  }
}
