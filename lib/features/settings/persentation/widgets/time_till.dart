import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/size_config.dart';
import 'settings_tile.dart';


class TimeTile extends StatelessWidget {
  final String time;
  final bool enabled;
  final VoidCallback onTap;
  final bool isDark;

  const TimeTile({
    super.key,
    required this.time,
    required this.enabled,
    required this.onTap,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return SettingsTile(
      icon: Icons.schedule,
      iconBg: AppColors.accentGreen.withOpacity(0.15),
      iconColor: AppColors.accentGreen,
      title: 'Reminder Time',
      isDark: isDark,
      trailing: Opacity(
        opacity: enabled ? 1 : 0.4,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.blockWidth * 3,
            vertical: SizeConfig.blockHeight * 0.8,
          ),
          decoration: BoxDecoration(
            color: isDark
                ? AppColors.darkSurfaceLight
                : AppColors.lightSurfaceDark,
            borderRadius:
                BorderRadius.circular(SizeConfig.blockWidth * 2),
          ),
          child: Text(
            time,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),
        ),
      ),
      onTap: enabled ? onTap : null,
    );
  }
}
