
import 'package:flutter/material.dart';
import 'package:app_links/app_links.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/constants/app_themes.dart';
import 'core/navigation/scaffold_messenger_key.dart';
import 'core/utils/navigator_key.dart';
import 'core/utils/size_config.dart';
import 'core/utils/custom_snackbar.dart';
import 'routes/app_routes.dart';
import 'routes/route_generator.dart';


class QuoteVaultApp extends StatefulWidget {
  const QuoteVaultApp({super.key});

  @override
  State<QuoteVaultApp> createState() => _QuoteVaultAppState();
}

class _QuoteVaultAppState extends State<QuoteVaultApp> {
  final AppLinks _appLinks = AppLinks();

  @override
  void initState() {
    super.initState();
    
    _listenToSupabaseAuthChanges(); // ✅ REQUIRED
    
    _handleInitialLink(); // ✅ cold start
    _listenToDeepLinks(); // ✅ background / foreground
  }
    void _listenToSupabaseAuthChanges() {
    Supabase.instance.client.auth.onAuthStateChange.listen((data) {
      final event = data.event;

      if (event == AuthChangeEvent.passwordRecovery) {
        debugPrint('✅ Supabase password recovery session active');
      }
    });
  }

  /// 🔥 APP OPENED FROM KILLED STATE
  Future<void> _handleInitialLink() async {
    final uri = await _appLinks.getInitialLink();

    if (uri != null) {
      _handleUri(uri);
    }
  }

  /// 🔥 APP OPENED FROM BACKGROUND
  void _listenToDeepLinks() {
    _appLinks.uriLinkStream.listen((uri) {
      if (uri != null) {
        _handleUri(uri);
      }
    });
  }

  /// 🔥 CENTRAL HANDLER
  void _handleUri(Uri uri) async{
    debugPrint('🔗 Deep link received: $uri');

    if (uri.scheme != 'quotevault') return;
      /// 🔥 CRITICAL — LET SUPABASE CONSUME THE TOKEN
      await Supabase.instance.client.auth.getSessionFromUrl(uri);


    if (uri.host == 'verify-email') {
      _navigateToLoginWithSnackbar();
    }

    if (uri.host == 'reset-password') {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        navigatorKey.currentState?.pushNamed(
          AppRoutes.resetpassword,
        );
      });
    }
  }

  /// ✅ SAFE NAVIGATION + SNACKBAR
  void _navigateToLoginWithSnackbar() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
     
      navigatorKey.currentState?.pushNamedAndRemoveUntil(
      AppRoutes.login,
      (route) => false,
    );
      Future.delayed(const Duration(milliseconds: 300), () {
        showCustomSnackbar(
        
          type: SnackbarType.success,
          title: 'Email Verified',
          message: 'Your email has been verified. Please login.',
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey, // 🔥 REQUIRED
      scaffoldMessengerKey: scaffoldMessengerKey,
      debugShowCheckedModeBanner: false,
      title: 'QuoteVault',

      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,

      initialRoute: AppRoutes.startup,
      onGenerateRoute: RouteGenerator.generateRoute,

      builder: (context, child) {
        SizeConfig.init(context);
        return child ?? const SizedBox.shrink();
      },
    );
  }
}
