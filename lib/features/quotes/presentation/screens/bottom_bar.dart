import 'package:flutter/material.dart';
import 'package:quotevault/features/explore/presentation/screens/explore_screen.dart';
import 'package:quotevault/features/quotes/presentation/screens/quote_vault_screen.dart';
import '../../../../core/widgets/custom_bottom_nav_bar.dart';
import '../../../favorites/presentation/screens/vault_screen.dart';
import '../../../settings/persentation/screens/setting_screen.dart';

class BottomBar extends StatefulWidget {
  static const String routeName = '/bottom-bar';

  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int currentIndex = 0;

  late final List<Widget> pages;

  @override
  void initState() {
    super.initState();

    pages = const [
      QuoteVaultScreen(),
      ExploreScreen(),
      VaultScreen(),
      SettingsScreen(),
    ];
  }

  void onTabChanged(int index) {
    if (index == currentIndex) return;

    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
          if (currentIndex != 0) {
    // 🔁 Go back to first tab instead of exiting app
    setState(() {
      currentIndex = 0;
    });
    return false; // prevent app exit
  }

  // ✅ On first tab → allow app to close
  return true;
      },
      child: Scaffold(
        body: IndexedStack(
          index: currentIndex,
          children: pages,
        ),
        bottomNavigationBar: CustomBottomNavBar(
          currentIndex: currentIndex,
          isDark: Theme.of(context).brightness == Brightness.dark,
          onTap: onTabChanged,
          onThemeToggle: () {
            // optional theme toggle
          },
        ),
      ),
    );
  }
}
