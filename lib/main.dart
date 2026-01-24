// // // // // // // // // import 'dart:async';
// // // // // // // // // import 'package:flutter/material.dart';
// // // // // // // // // import 'package:flutter_dotenv/flutter_dotenv.dart';
// // // // // // // // // import 'package:provider/provider.dart';
// // // // // // // // // import 'package:supabase_flutter/supabase_flutter.dart';

// // // // // // // // // import 'app.dart';
// // // // // // // // // import 'core/config/supabase_config.dart';
// // // // // // // // // import 'di/service_locator.dart';
// // // // // // // // // import 'features/auth/domain/repositories/auth_repository_impl.dart';
// // // // // // // // // import 'features/auth/presentation/provider/auth_provider.dart';
// // // // // // // // // import 'features/explore/presentation/provider/explore_provider.dart';
// // // // // // // // // import 'features/favorites/presentation/provider/favorites_provider.dart';

// // // // // // // // // import 'features/profile/presentation/provider/profile_provider.dart';
// // // // // // // // // import 'features/quotes/presentation/provider/quote_provider.dart';

// // // // // // // // // Future<void> main() async {
// // // // // // // // //   WidgetsFlutterBinding.ensureInitialized();

// // // // // // // // //   await dotenv.load(fileName: ".env");
// // // // // // // // //   // 🔗 Initialize Supabase
// // // // // // // // //   await Supabase.initialize(
// // // // // // // // //     url: SupabaseConfig.url,
// // // // // // // // //     anonKey: SupabaseConfig.anonKey,
// // // // // // // // //   );

// // // // // // // // //   // 🔗 Initialize Dependency Injection
// // // // // // // // //   await setupServiceLocator();

// // // // // // // // //   // ❗ Global Flutter error handling

// // // // // // // // //   // ❗ Catch async errors

// // // // // // // // //   // ...existing code...
// // // // // // // // //   runApp(
// // // // // // // // //     MultiProvider(
// // // // // // // // //       providers: [
// // // // // // // // //         ChangeNotifierProvider(
// // // // // // // // //           create: (_) => AuthProvider(sl<AuthRepository>()),

// // // // // // // // //         ),
// // // // // // // // //          ChangeNotifierProxyProvider<AuthProvider, ProfileProvider>(
// // // // // // // // //           create: (_) => ProfileProvider(),
// // // // // // // // //           update: (_, authProvider, profileProvider) {
// // // // // // // // //             // Only load profile if user is logged in
// // // // // // // // //             if (authProvider.user != null) {
// // // // // // // // //               profileProvider ??= ProfileProvider();
// // // // // // // // //               profileProvider.loadProfile();
// // // // // // // // //             }
// // // // // // // // //             return profileProvider!;
// // // // // // // // //           },
// // // // // // // // //         ),
// // // // // // // // //         ChangeNotifierProvider(
// // // // // // // // //           create: (_) => QuoteProvider(),
// // // // // // // // //         ),
// // // // // // // // //         ChangeNotifierProvider(
// // // // // // // // //           create: (_) => FavoritesProvider(),
// // // // // // // // //         ),
// // // // // // // // //         ChangeNotifierProvider(
// // // // // // // // //           create: (_) => ExploreProvider(),
// // // // // // // // //         ),

// // // // // // // // //       ],
// // // // // // // // //       child: const QuoteVaultApp(),
// // // // // // // // //     ),
// // // // // // // // //   );
// // // // // // // // // }

// // // // // // // // // // import 'package:flutter/material.dart';

// // // // // // // // // // import 'core/constants/app_colors.dart';
// // // // // // // // // // import 'core/utils/size_config.dart';

// // // // // // // // // // void main() {
// // // // // // // // // //   runApp(const MyApp());
// // // // // // // // // // }

// // // // // // // // // // class MyApp extends StatelessWidget {
// // // // // // // // // //   const MyApp({Key? key}) : super(key: key);

// // // // // // // // // //   @override
// // // // // // // // // //   Widget build(BuildContext context) {
// // // // // // // // // //     return MaterialApp(
// // // // // // // // // //       title: 'Bottom Nav Bar Demo',
// // // // // // // // // //       theme: ThemeData(
// // // // // // // // // //         useMaterial3: true,
// // // // // // // // // //         brightness: Brightness.dark,
// // // // // // // // // //       ),
// // // // // // // // // //       home: const HomeScreen(),
// // // // // // // // // //     );
// // // // // // // // // //   }
// // // // // // // // // // }

// // // // // // // // // // class HomeScreen extends StatefulWidget {
// // // // // // // // // //   const HomeScreen({Key? key}) : super(key: key);

// // // // // // // // // //   @override
// // // // // // // // // //   State<HomeScreen> createState() => _HomeScreenState();
// // // // // // // // // // }

// // // // // // // // // // class _HomeScreenState extends State<HomeScreen> {
// // // // // // // // // //   int currentIndex = 0;
// // // // // // // // // //   bool isDark = true;

// // // // // // // // // //   late final List<Widget> pages;

// // // // // // // // // //   @override
// // // // // // // // // //   void initState() {
// // // // // // // // // //     super.initState();
// // // // // // // // // //     _initializePages();
// // // // // // // // // //   }

// // // // // // // // // //   void _initializePages() {
// // // // // // // // // //     pages = [
// // // // // // // // // //       const PageContent(title: 'Quotes', color: AppColors.primaryColor),
// // // // // // // // // //       const PageContent(title: 'Explore', color: AppColors.accentGreen),
// // // // // // // // // //       const PageContent(title: 'Saved', color: AppColors.accentOrange),
// // // // // // // // // //       const PageContent(title: 'Settings', color: AppColors.primaryColor),
// // // // // // // // // //     ];
// // // // // // // // // //   }

// // // // // // // // // //   @override
// // // // // // // // // //   Widget build(BuildContext context) {
// // // // // // // // // //     SizeConfig.init(context);
// // // // // // // // // //     return Scaffold(
// // // // // // // // // //       backgroundColor: isDark ? AppColors.darkBg : AppColors.lightBg,
// // // // // // // // // //       body: pages[currentIndex],
// // // // // // // // // //       bottomNavigationBar: CustomBottomNavBar(
// // // // // // // // // //         currentIndex: currentIndex,
// // // // // // // // // //         isDark: isDark,
// // // // // // // // // //         onTap: (index) {
// // // // // // // // // //           setState(() {
// // // // // // // // // //             currentIndex = index;
// // // // // // // // // //           });
// // // // // // // // // //         },
// // // // // // // // // //         onThemeToggle: () {
// // // // // // // // // //           setState(() {
// // // // // // // // // //             isDark = !isDark;
// // // // // // // // // //           });
// // // // // // // // // //         },
// // // // // // // // // //       ),
// // // // // // // // // //     );
// // // // // // // // // //   }
// // // // // // // // // // }

// // // // // // // // // // class CustomBottomNavBar extends StatelessWidget {
// // // // // // // // // //   final int currentIndex;
// // // // // // // // // //   final bool isDark;
// // // // // // // // // //   final Function(int) onTap;
// // // // // // // // // //   final VoidCallback onThemeToggle;

// // // // // // // // // //   const CustomBottomNavBar({
// // // // // // // // // //     Key? key,
// // // // // // // // // //     required this.currentIndex,
// // // // // // // // // //     required this.isDark,
// // // // // // // // // //     required this.onTap,
// // // // // // // // // //     required this.onThemeToggle,
// // // // // // // // // //   }) : super(key: key);

// // // // // // // // // //   @override
// // // // // // // // // //   Widget build(BuildContext context) {
// // // // // // // // // //     final navItems = [
// // // // // // // // // //       _NavItem(
// // // // // // // // // //         icon: Icons.format_quote,
// // // // // // // // // //         label: 'Quotes',
// // // // // // // // // //         index: 0,
// // // // // // // // // //       ),
// // // // // // // // // //       _NavItem(
// // // // // // // // // //         icon: Icons.explore,
// // // // // // // // // //         label: 'Explore',
// // // // // // // // // //         index: 1,
// // // // // // // // // //       ),
// // // // // // // // // //       _NavItem(
// // // // // // // // // //         icon: Icons.favorite,
// // // // // // // // // //         label: 'vault',
// // // // // // // // // //         index: 2,
// // // // // // // // // //       ),
// // // // // // // // // //       _NavItem(
// // // // // // // // // //         icon: Icons.settings,
// // // // // // // // // //         label: 'Settings',
// // // // // // // // // //         index: 3,
// // // // // // // // // //       ),
// // // // // // // // // //     ];

// // // // // // // // // //     return Container(
// // // // // // // // // //       height: 65,
// // // // // // // // // //       decoration: BoxDecoration(
// // // // // // // // // //         color: isDark ? AppColors.darkSurfaceLight : AppColors.lightSurfaceLight,
// // // // // // // // // //         border: Border(
// // // // // // // // // //           top: BorderSide(
// // // // // // // // // //             color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
// // // // // // // // // //             width: 1,
// // // // // // // // // //           ),
// // // // // // // // // //         ),
// // // // // // // // // //       ),
// // // // // // // // // //       child: Row(
// // // // // // // // // //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// // // // // // // // // //         children: List.generate(
// // // // // // // // // //           navItems.length,
// // // // // // // // // //           (index) => _NavBarItem(
// // // // // // // // // //             item: navItems[index],
// // // // // // // // // //             isActive: currentIndex == index,
// // // // // // // // // //             isDark: isDark,
// // // // // // // // // //             onTap: () => onTap(index),
// // // // // // // // // //           ),
// // // // // // // // // //         ),
// // // // // // // // // //       ),
// // // // // // // // // //     );
// // // // // // // // // //   }
// // // // // // // // // // }

// // // // // // // // // // class _NavBarItem extends StatelessWidget {
// // // // // // // // // //   final _NavItem item;
// // // // // // // // // //   final bool isActive;
// // // // // // // // // //   final bool isDark;
// // // // // // // // // //   final VoidCallback onTap;

// // // // // // // // // //   const _NavBarItem({
// // // // // // // // // //     Key? key,
// // // // // // // // // //     required this.item,
// // // // // // // // // //     required this.isActive,
// // // // // // // // // //     required this.isDark,
// // // // // // // // // //     required this.onTap,
// // // // // // // // // //   }) : super(key: key);

// // // // // // // // // //   @override
// // // // // // // // // //   Widget build(BuildContext context) {
// // // // // // // // // //     final inactiveColor =
// // // // // // // // // //         isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

// // // // // // // // // //     return GestureDetector(
// // // // // // // // // //       behavior: HitTestBehavior.opaque, // 👈 better tap area
// // // // // // // // // //       onTap: onTap,
// // // // // // // // // //       child: Padding(
// // // // // // // // // //         padding: const EdgeInsets.symmetric(
// // // // // // // // // //           horizontal: 14, // 👈 more spacing between items
// // // // // // // // // //           vertical: 8,
// // // // // // // // // //         ),
// // // // // // // // // //         child: AnimatedScale(
// // // // // // // // // //           scale: isActive ? 1.08 : 1.0, // 👈 minimal zoom
// // // // // // // // // //           duration: const Duration(milliseconds: 200),
// // // // // // // // // //           curve: Curves.easeOut,
// // // // // // // // // //           child: Column(
// // // // // // // // // //             mainAxisAlignment: MainAxisAlignment.center,
// // // // // // // // // //             children: [
// // // // // // // // // //               Icon(
// // // // // // // // // //                 item.icon,
// // // // // // // // // //                 size: isActive ? 26 : 24, // 👈 optional micro emphasis
// // // // // // // // // //                 color: isActive
// // // // // // // // // //                     ? AppColors.primaryColor
// // // // // // // // // //                     : inactiveColor,
// // // // // // // // // //               ),
// // // // // // // // // //               const SizedBox(height: 4), // 👈 more spacing
// // // // // // // // // //               Text(
// // // // // // // // // //                 item.label,
// // // // // // // // // //                 style: TextStyle(
// // // // // // // // // //                   fontSize: 11,
// // // // // // // // // //                   fontWeight:
// // // // // // // // // //                       isActive ? FontWeight.w600 : FontWeight.w500,
// // // // // // // // // //                   color: isActive
// // // // // // // // // //                       ? AppColors.primaryColor
// // // // // // // // // //                       : inactiveColor,
// // // // // // // // // //                 ),
// // // // // // // // // //               ),
// // // // // // // // // //             ],
// // // // // // // // // //           ),
// // // // // // // // // //         ),
// // // // // // // // // //       ),
// // // // // // // // // //     );
// // // // // // // // // //   }
// // // // // // // // // // }

// // // // // // // // // // class _NavItem {
// // // // // // // // // //   final IconData icon;
// // // // // // // // // //   final String label;
// // // // // // // // // //   final int index;

// // // // // // // // // //   _NavItem({
// // // // // // // // // //     required this.icon,
// // // // // // // // // //     required this.label,
// // // // // // // // // //     required this.index,
// // // // // // // // // //   });
// // // // // // // // // // }

// // // // // // // // // // class PageContent extends StatelessWidget {
// // // // // // // // // //   final String title;
// // // // // // // // // //   final Color color;

// // // // // // // // // //   const PageContent({
// // // // // // // // // //     Key? key,
// // // // // // // // // //     required this.title,
// // // // // // // // // //     required this.color,
// // // // // // // // // //   }) : super(key: key);

// // // // // // // // // //   @override
// // // // // // // // // //   Widget build(BuildContext context) {
// // // // // // // // // //     return Center(
// // // // // // // // // //       child: Column(
// // // // // // // // // //         mainAxisAlignment: MainAxisAlignment.center,
// // // // // // // // // //         children: [
// // // // // // // // // //           Container(
// // // // // // // // // //             width: 80,
// // // // // // // // // //             height: 80,
// // // // // // // // // //             decoration: BoxDecoration(
// // // // // // // // // //               color: color.withOpacity(0.2),
// // // // // // // // // //               shape: BoxShape.circle,
// // // // // // // // // //             ),
// // // // // // // // // //             child: Icon(
// // // // // // // // // //               Icons.check,
// // // // // // // // // //               size:80,
// // // // // // // // // //               color: color,
// // // // // // // // // //             ),
// // // // // // // // // //           ),
// // // // // // // // // //           const SizedBox(height: 20),
// // // // // // // // // //           Text(
// // // // // // // // // //             title,
// // // // // // // // // //             style: const TextStyle(
// // // // // // // // // //               fontSize: 28,
// // // // // // // // // //               fontWeight: FontWeight.bold,
// // // // // // // // // //               color: AppColors.darkTextPrimary,
// // // // // // // // // //             ),
// // // // // // // // // //           ),
// // // // // // // // // //           const SizedBox(height: 12),
// // // // // // // // // //           Text(
// // // // // // // // // //             'Page $title Content',
// // // // // // // // // //             style: const TextStyle(
// // // // // // // // // //               fontSize: 16,
// // // // // // // // // //               color: AppColors.darkTextSecondary,
// // // // // // // // // //             ),
// // // // // // // // // //           ),
// // // // // // // // // //         ],
// // // // // // // // // //       ),
// // // // // // // // // //     );
// // // // // // // // // //   }
// // // // // // // // // // }
// // // // // // // // import 'dart:async';
// // // // // // // // import 'package:flutter/material.dart';
// // // // // // // // import 'package:flutter_dotenv/flutter_dotenv.dart';
// // // // // // // // import 'package:provider/provider.dart';
// // // // // // // // import 'package:supabase_flutter/supabase_flutter.dart';
// // // // // // // // import 'package:firebase_core/firebase_core.dart';
// // // // // // // // import 'package:firebase_messaging/firebase_messaging.dart';

// // // // // // // // import 'app.dart';
// // // // // // // // import 'core/config/supabase_config.dart';
// // // // // // // // import 'core/services/notification_service.dart';
// // // // // // // // import 'di/service_locator.dart';

// // // // // // // // import 'features/auth/domain/repositories/auth_repository_impl.dart';
// // // // // // // // import 'features/auth/presentation/provider/auth_provider.dart';
// // // // // // // // import 'features/explore/presentation/provider/explore_provider.dart';
// // // // // // // // import 'features/favorites/presentation/provider/favorites_provider.dart';
// // // // // // // // import 'features/profile/presentation/provider/profile_provider.dart';
// // // // // // // // import 'features/quotes/presentation/provider/quote_provider.dart';

// // // // // // // // /// 🔔 REQUIRED: Background handler
// // // // // // // // Future<void> _firebaseMessagingBackgroundHandler(
// // // // // // // //   RemoteMessage message,
// // // // // // // // ) async {
// // // // // // // //   await Firebase.initializeApp();
// // // // // // // // }

// // // // // // // // Future<void> main() async {
// // // // // // // //   WidgetsFlutterBinding.ensureInitialized();

// // // // // // // //   /// 🌱 Load env
// // // // // // // //   await dotenv.load(fileName: ".env");

// // // // // // // //   /// 🔥 Firebase init
// // // // // // // //   await Firebase.initializeApp();

// // // // // // // //   /// 🔔 Register background handler
// // // // // // // //   FirebaseMessaging.onBackgroundMessage(
// // // // // // // //     _firebaseMessagingBackgroundHandler,
// // // // // // // //   );

// // // // // // // //   /// 🔗 Supabase init
// // // // // // // //   await Supabase.initialize(
// // // // // // // //     url: SupabaseConfig.url,
// // // // // // // //     anonKey: SupabaseConfig.anonKey,
// // // // // // // //   );

// // // // // // // //   /// 🔗 Dependency Injection
// // // // // // // //   await setupServiceLocator();

// // // // // // // //   /// 🔔 Notification permission
// // // // // // // //   final messaging = FirebaseMessaging.instance;
// // // // // // // //   await messaging.requestPermission(
// // // // // // // //     alert: true,
// // // // // // // //     badge: true,
// // // // // // // //     sound: true,
// // // // // // // //   );

// // // // // // // //   /// 🔔 Print FCM token (DEBUG – OK)
// // // // // // // //   final token = await messaging.getToken();
// // // // // // // //   debugPrint("🔥 FCM TOKEN: $token");

// // // // // // // //   /// 🔔 Foreground notifications
// // // // // // // //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
// // // // // // // //     debugPrint('🔔 Foreground notification received');
// // // // // // // //   });

// // // // // // // //   runApp(
// // // // // // // //     MultiProvider(
// // // // // // // //       providers: [
// // // // // // // //         ChangeNotifierProvider(
// // // // // // // //           create: (_) => AuthProvider(sl<AuthRepository>()),
// // // // // // // //         ),

// // // // // // // //         ChangeNotifierProxyProvider<AuthProvider, ProfileProvider>(
// // // // // // // //           create: (_) => ProfileProvider(),
// // // // // // // //           update: (_, authProvider, profileProvider) {
// // // // // // // //             if (authProvider.user != null) {
// // // // // // // //               profileProvider ??= ProfileProvider();
// // // // // // // //               profileProvider.loadProfile();
// // // // // // // //             }
// // // // // // // //             return profileProvider!;
// // // // // // // //           },
// // // // // // // //         ),

// // // // // // // //         ChangeNotifierProvider(create: (_) => QuoteProvider()),
// // // // // // // //         ChangeNotifierProvider(create: (_) => FavoritesProvider()),
// // // // // // // //         ChangeNotifierProvider(create: (_) => ExploreProvider()),
// // // // // // // //       ],
// // // // // // // //       child: const QuoteVaultApp(),
// // // // // // // //     ),
// // // // // // // //   );

// // // // // // // //   /// 🔔 SAVE FCM TOKEN AFTER LOGIN
// // // // // // // //   Supabase.instance.client.auth.onAuthStateChange.listen((event) async {
// // // // // // // //     final user = event.session?.user;
// // // // // // // //     if (user != null) {
// // // // // // // //       await NotificationService.saveFcmToken(user.id);
// // // // // // // //     }
// // // // // // // //   });
// // // // // // // // }
// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:provider/provider.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// import 'app.dart';
// import 'core/config/supabase_config.dart';
// import 'core/services/notification_service.dart';
// import 'di/service_locator.dart';

// import 'features/auth/domain/repositories/auth_repository_impl.dart';
// import 'features/auth/presentation/provider/auth_provider.dart';
// import 'features/explore/presentation/provider/explore_provider.dart';
// import 'features/favorites/presentation/provider/favorites_provider.dart';
// import 'features/profile/presentation/provider/profile_provider.dart';
// import 'features/quotes/presentation/provider/quote_provider.dart';

// /// 🔔 Background handler (REQUIRED)
// Future<void> _firebaseMessagingBackgroundHandler(
//   RemoteMessage message,
// ) async {
//   await Firebase.initializeApp();
// }

// /// 🔔 Local notifications plugin
// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();

// /// 🔔 Android notification channel (MUST MATCH EDGE FUNCTION)
// const AndroidNotificationChannel highImportanceChannel =
//     AndroidNotificationChannel(
//   'high_importance_channel',
//   'High Importance Notifications',
//   description: 'Daily quote notifications',
//   importance: Importance.high,
// );

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   /// 🌱 Load environment
//   await dotenv.load(fileName: ".env");

//   /// 🔥 Firebase init
//   await Firebase.initializeApp();

//   /// 🔔 Background FCM handler
//   FirebaseMessaging.onBackgroundMessage(
//     _firebaseMessagingBackgroundHandler,
//   );

//   /// 🔗 Supabase init
//   await Supabase.initialize(
//     url: SupabaseConfig.url,
//     anonKey: SupabaseConfig.anonKey,
//   );

//   /// 🔗 Dependency injection
//   await setupServiceLocator();

//   /* ================= LOCAL NOTIFICATIONS INIT ================= */

//   const AndroidInitializationSettings androidInit =
//       AndroidInitializationSettings('@mipmap/ic_launcher');

//   const InitializationSettings initSettings =
//       InitializationSettings(android: androidInit);

//   await flutterLocalNotificationsPlugin.initialize(initSettings);

//   /// 🔔 Create Android notification channel (CRITICAL)
//   await flutterLocalNotificationsPlugin
//       .resolvePlatformSpecificImplementation<
//           AndroidFlutterLocalNotificationsPlugin>()
//       ?.createNotificationChannel(highImportanceChannel);

//   /* ================= FIREBASE MESSAGING ================= */

//   final messaging = FirebaseMessaging.instance;

//   /// 🔔 Request permission (Android 13+)
//   await messaging.requestPermission(
//     alert: true,
//     badge: true,
//     sound: true,
//   );

//   /// 🔔 Print token (DEBUG)
//   final token = await messaging.getToken();
//   debugPrint("🔥 FCM TOKEN: $token");

//   /// 🔔 Foreground notification handling (SHOW UI)
//   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//     final notification = message.notification;
//     if (notification == null) return;

//     flutterLocalNotificationsPlugin.show(
//       notification.hashCode,
//       notification.title,
//       notification.body,
//       const NotificationDetails(
//         android: AndroidNotificationDetails(
//           'high_importance_channel',
//           'High Importance Notifications',
//           importance: Importance.high,
//           priority: Priority.high,
//         ),
//       ),
//     );
//   });

//   /* ================= RUN APP ================= */

//   runApp(
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider(
//           create: (_) => AuthProvider(sl<AuthRepository>()),
//         ),
//         ChangeNotifierProvider(create: (_) => ProfileProvider()),
//         ChangeNotifierProvider(create: (_) => QuoteProvider()),
//         ChangeNotifierProvider(create: (_) => FavoritesProvider()),
//         ChangeNotifierProvider(create: (_) => ExploreProvider()),
//       ],
//       child: const QuoteVaultApp(),
//     ),
//   );

//   /* ================= SAVE FCM TOKEN AFTER LOGIN ================= */

//   Supabase.instance.client.auth.onAuthStateChange.listen((event) async {
//     final user = event.session?.user;
//     if (user != null) {
//       await NotificationService.saveFcmToken(user.id);
//     }
//   });
// }

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

