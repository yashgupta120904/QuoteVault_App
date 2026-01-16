import 'package:flutter/material.dart';

import '../../routes/app_routes.dart';
import '../utils/app_prefs.dart';

class AppStartup extends StatefulWidget {
  const AppStartup ({super.key});

  @override
  State<AppStartup > createState() => _AppStartupState();
}

class _AppStartupState extends State<AppStartup> {
  @override
  void initState() {
    super.initState();
    _decideRoute();
  }

  Future<void> _decideRoute() async {
    final isLoggedIn = await AppPrefs.isLoggedIn();

    if (!mounted) return;

    Navigator.pushReplacementNamed(
      context,
      isLoggedIn ? AppRoutes.bottombar: AppRoutes.welcome,
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
