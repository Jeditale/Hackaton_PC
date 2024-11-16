import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:nirva/services/display_payload_page.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationServices {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static GlobalKey<NavigatorState> globalKey = GlobalKey<NavigatorState>();
  static NotificationDetails notificationDetails = const NotificationDetails(
    android: AndroidNotificationDetails(
      "channelId",
      "channelName",
      priority: Priority.high,
      importance: Importance.high,
      icon: "@mipmap/ic_launcher",
    ),
  );

  static Future<void> init() async {
    AndroidInitializationSettings androidInitializationSettings =
        const AndroidInitializationSettings("@mipmap/ic_launcher");
    InitializationSettings initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
      onDidReceiveBackgroundNotificationResponse:
          onDidReceiveBackgroundNotificationResponse,
    );
  }

  static void askForNotificationPermission() {
    Permission.notification.request().then((permissionStatus) {
      if (permissionStatus != PermissionStatus.granted) {
        AppSettings.openAppSettings(type: AppSettingsType.notification);
        // Forcing user to grant notification permission
      }
      return;
    });
  }

  static void sendInstantNotification(
      {required String title, required String body, required String payload}) {
    // used 0 as an id for this notification
    // id is an integer to identify the notification
    flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      notificationDetails,
      payload: payload,
    );
  }

  static void sendPeriodicNotification(
      {required String title, required String body, required String payload}) {
    // used 1 as an id for this notification
    // id is an integer to identify the notification
    flutterLocalNotificationsPlugin.periodicallyShow(
      1,
      title,
      body,
      RepeatInterval.everyMinute,
      notificationDetails,
      payload: payload,
    );
  }

  static Future<void> cancelPeriodicNotification() async {
    await flutterLocalNotificationsPlugin
        .cancel(1); // used 1 as an id to cancel periodic notification
  }

  static void onDidReceiveNotificationResponse(NotificationResponse response) {
    debugPrint("onDidReceiveNotificationResponse");
    globalKey.currentState?.pushReplacement(
      MaterialPageRoute(
        builder: (context) => DisplayPayload(
          payloadData: response.payload,
        ),
      ),
    );
  }

  static void onDidReceiveBackgroundNotificationResponse(
      NotificationResponse response) {
    debugPrint("onDidReceiveBackgroundNotificationResponse");
    globalKey.currentState?.pushReplacement(
      MaterialPageRoute(
        builder: (context) => DisplayPayload(
          payloadData: response.payload,
        ),
      ),
    );
  }
}
