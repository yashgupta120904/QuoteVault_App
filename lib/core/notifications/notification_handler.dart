import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:quotevault/routes/app_routes.dart';

class NotificationHandler {
  static void setup(BuildContext context) {
    // App opened from terminated state
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        _handleMessage(context, message);
      }
    });

    // App opened from background
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      _handleMessage(context, message);
    });
  }

  static void _handleMessage(
    BuildContext context,
    RemoteMessage message,
  ) {
    final screen = message.data['screen'];

    if (screen == 'daily_quote') {
      Navigator.pushNamed(context, AppRoutes.bottombar);
    }
  }
}
