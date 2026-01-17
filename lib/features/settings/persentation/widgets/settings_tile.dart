import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/size_config.dart';


class SettingsTile extends StatelessWidget {
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String title;
  final Widget trailing;
  final bool hasDivider;
  final VoidCallback? onTap;
  final bool isDark;

  const SettingsTile({
    super.key,
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.title,
    required this.trailing,
    required this.isDark,
    this.hasDivider = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: hasDivider
              ? Border(
                  bottom: BorderSide(
                    color: isDark
                        ? AppColors.dividerDark
                        : AppColors.dividerLight,
                  ),
                )
              : null,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.blockWidth * 4,
          vertical: SizeConfig.blockHeight * 1.8,
        ),
        child: Row(
          children: [
            Container(
              width: SizeConfig.blockWidth * 8,
              height: SizeConfig.blockWidth * 8,
              decoration: BoxDecoration(
                color: iconBg,
                borderRadius:
                    BorderRadius.circular(SizeConfig.blockWidth * 2),
              ),
              child: Icon(icon, color: iconColor),
            ),
            SizedBox(width: SizeConfig.blockWidth * 3),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: SizeConfig.blockWidth * 3.8,
                  color: isDark
                      ? AppColors.darkTextPrimary
                      : AppColors.lightTextPrimary,
                ),
              ),
            ),
            trailing,
          ],
        ),
      ),
    );
  }
}
