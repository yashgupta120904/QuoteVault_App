import 'package:flutter/material.dart';
import 'package:quotevault/core/startup/app_startup.dart';
import 'package:quotevault/features/auth/presentation/screens/forgotPassword_screen.dart';
import 'package:quotevault/features/auth/presentation/screens/login_screen.dart';
import 'package:quotevault/features/auth/presentation/screens/reset_password_screen.dart';
import 'package:quotevault/features/auth/presentation/screens/signup_screen.dart';
import 'package:quotevault/features/settings/persentation/screens/setting_screen.dart';
import 'package:quotevault/features/share/presentation/screens/share_screen.dart';

import '../features/auth/presentation/screens/welcome_screen.dart';
import '../features/explore/presentation/screens/explore_screen.dart';

import '../features/favorites/presentation/screens/vault_screen.dart';
import '../features/quotes/presentation/screens/bottom_bar.dart';
import 'app_routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.startup:
        return MaterialPageRoute(
          builder: (_) => const AppStartup(),
        );

      case AppRoutes.welcome:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const WelcomePage(),
        );
      case AppRoutes.login:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );
      case AppRoutes.resetpassword:
        return MaterialPageRoute(
          builder: (_) => const ResetPasswordScreen(),
        );
      case AppRoutes.forgotpassword:
        return MaterialPageRoute(
          builder: (_) => const ForgotPasswordScreen(),
        );
      case AppRoutes.signup:
        return MaterialPageRoute(
          builder: (_) => const SignupScreen(),
        );

      //Quote Section

      case AppRoutes.bottombar:
        return MaterialPageRoute(
          builder: (_) => const BottomBar(),
        );
      case AppRoutes.explore:
        return MaterialPageRoute(
          builder: (_) => const ExploreScreen(),
        );

      case AppRoutes.vault:
        return MaterialPageRoute(
          builder: (_) => const VaultScreen(),
        );
      case AppRoutes.setting:
        return MaterialPageRoute(builder: (_) => const SettingsScreen());

         case AppRoutes.share:
        return MaterialPageRoute(builder: (_) => const ShareScreen());


      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Route not found'),
            ),
          ),
        );
    }
  }
}
