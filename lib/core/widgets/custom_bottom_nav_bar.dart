import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../utils/size_config.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final bool isDark;
  final Function(int) onTap;
  final VoidCallback onThemeToggle;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.isDark,
    required this.onTap,
    required this.onThemeToggle,
  });

  @override
  Widget build(BuildContext context) {
    final navItems = [
      const _NavItem(icon: Icons.format_quote, label: 'Quotes', index: 0),
     const  _NavItem(icon: Icons.explore, label: 'Explore', index: 1),
      const _NavItem(icon: Icons.favorite, label: 'Vault', index: 2),
     const  _NavItem(icon: Icons.settings, label: 'Settings', index: 3),
    ];

    return Container(
      height: SizeConfig.blockHeight * 8,
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.darkSurfaceLight
            : AppColors.lightSurfaceLight,
        border: Border(
          top: BorderSide(
            color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          navItems.length,
          (index) => _NavBarItem(
            item: navItems[index],
            isActive: currentIndex == index,
            isDark: isDark,
            onTap: () => onTap(index),
          ),
        ),
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final _NavItem item;
  final bool isActive;
  final bool isDark;
  final VoidCallback onTap;

  const _NavBarItem({
    required this.item,
    required this.isActive,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final inactiveColor =
        isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.blockWidth * 3.5,
          vertical: SizeConfig.blockHeight * 0.8,
        ),
        child: AnimatedScale(
          scale: isActive ? 1.08 : 1.0,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                item.icon,
                size: isActive
                    ? SizeConfig.blockWidth * 6.8
                    : SizeConfig.blockWidth * 6.2,
                color: isActive
                    ? AppColors.primaryColor
                    : inactiveColor,
              ),
              SizedBox(height: SizeConfig.blockHeight * 0.4),
              Text(
                item.label,
                style: TextStyle(
                  fontSize: SizeConfig.blockWidth * 2.6,
                  fontWeight:
                      isActive ? FontWeight.w600 : FontWeight.w500,
                  color: isActive
                      ? AppColors.primaryColor
                      : inactiveColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;
  final int index;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.index,
  });
}
