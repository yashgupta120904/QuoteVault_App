

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:workmanager/workmanager.dart';
import 'package:home_widget/home_widget.dart';

import 'app.dart';
import 'core/config/supabase_config.dart';
import 'core/services/notification_service.dart';
import 'di/service_locator.dart';

import 'features/auth/domain/repositories/auth_repository_impl.dart';
import 'features/auth/presentation/provider/auth_provider.dart';
import 'features/explore/presentation/provider/explore_provider.dart';
import 'features/favorites/presentation/provider/favorites_provider.dart';
import 'features/profile/presentation/provider/profile_provider.dart';
import 'features/quotes/presentation/provider/quote_provider.dart';
import 'features/settings/persentation/screens/provider/theme_provider.dart';

/// 🔔 FCM Background handler (REQUIRED)
Future<void> _firebaseMessagingBackgroundHandler(
  RemoteMessage message,
) async {
  await Firebase.initializeApp();
}

/// 🧩 WIDGET BACKGROUND CALLBACK (REQUIRED)
void widgetCallbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    try {
  
      const quote = "Roz thoda better bano 💪";
      const author = "QuoteVault";
   

      await HomeWidget.saveWidgetData('daily_quote', quote);
      await HomeWidget.saveWidgetData('quote_author', author);
     

      // change gradient daily
      final day = DateTime.now().day % 2;
      await HomeWidget.saveWidgetData('bg_index', day);

      await HomeWidget.updateWidget(
  name: 'HomeWidgetExampleProvider', // No dot here
  androidName: 'HomeWidgetExampleProvider', // No dot here
);


      return Future.value(true);
    } catch (e) {
      return Future.value(false);
    }
  });
}

/// 🔔 Local notifications plugin
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

/// 🔔 Android notification channel
const AndroidNotificationChannel highImportanceChannel =
    AndroidNotificationChannel(
  'high_importance_channel',
  'High Importance Notifications',
  description: 'Daily quote notifications',
  importance: Importance.high,
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// 🌱 Load environment
  await dotenv.load(fileName: ".env");

  /// 🔥 Firebase init
  await Firebase.initializeApp();

  /// 🔔 Background FCM handler
  FirebaseMessaging.onBackgroundMessage(
    _firebaseMessagingBackgroundHandler,
  );

  /// 🔗 Supabase init
  await Supabase.initialize(
    url: SupabaseConfig.url,
    anonKey: SupabaseConfig.anonKey,
  );

  /// 🔗 Dependency injection
  await setupServiceLocator();

  /* ================= WORKMANAGER INIT (HOME WIDGET) ================= */

  Workmanager().initialize(
    widgetCallbackDispatcher,
    isInDebugMode: false,
  );

  // Daily widget update (24h)
  Workmanager().registerPeriodicTask(
    "dailyQuoteWidgetTask",
    "dailyQuoteWidgetTask",
    frequency: const Duration(hours: 24),
  );

  /* ================= LOCAL NOTIFICATIONS INIT ================= */

  const AndroidInitializationSettings androidInit =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initSettings =
      InitializationSettings(android: androidInit);

  await flutterLocalNotificationsPlugin.initialize(initSettings);

  /// 🔔 Create Android notification channel
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(highImportanceChannel);

  /* ================= FIREBASE MESSAGING ================= */

  final messaging = FirebaseMessaging.instance;

  /// 🔔 Request permission (Android 13+)
  await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  /// 🔔 Print token (DEBUG)
  final token = await messaging.getToken();
  debugPrint("🔥 FCM TOKEN: $token");

  /// 🔔 Foreground notification handling
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    final notification = message.notification;
    if (notification == null) return;

    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'high_importance_channel',
          'High Importance Notifications',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
    );
  });

  /* ================= RUN APP ================= */

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(sl<AuthRepository>()),
        ),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => QuoteProvider()),
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
        ChangeNotifierProvider(create: (_) => ExploreProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const QuoteVaultApp(),
    ),
  );

  /* ================= SAVE FCM TOKEN AFTER LOGIN ================= */

  Supabase.instance.client.auth.onAuthStateChange.listen((event) async {
    final user = event.session?.user;
    if (user != null) {
      await NotificationService.saveFcmToken(user.id);
    }
  });
}


