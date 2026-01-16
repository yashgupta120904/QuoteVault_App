import 'package:flutter/material.dart';
import '../../../../core/widgets/custom_bottom_nav_bar.dart';
import '../../../../core/utils/size_config.dart';




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
      Center(child: Text("#!")),
      Center(child: Text("#!")),
      Center(child: Text("#!")),
      Center(child: Text("#!")),
     
    ];
  }

  void onTabChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // REQUIRED for responsive sizes
    SizeConfig.init(context);

    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: currentIndex,
        isDark: Theme.of(context).brightness == Brightness.dark,
        onTap: onTabChanged,
        onThemeToggle: () {
          // optional theme toggle
        },
      ),
    );
  }
}
