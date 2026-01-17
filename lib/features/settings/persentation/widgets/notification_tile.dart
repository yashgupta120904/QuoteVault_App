import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import 'settings_tile.dart';

class NotificationTile extends StatelessWidget {
  final bool enabled;
  final ValueChanged<bool> onChanged;
  final bool isDark;

  const NotificationTile({
    super.key,
    required this.enabled,
    required this.onChanged,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return SettingsTile(
      icon: Icons.notifications_active,
      iconBg: AppColors.accentRed.withOpacity(0.15),
      iconColor: AppColors.accentRed,
      title: 'Daily Quote Reminders',
      isDark: isDark,
      trailing: Switch.adaptive(
        value: enabled,
        activeColor: AppColors.primaryColor,
        onChanged: onChanged,
      ),
      hasDivider: true,
    );
  }
}
