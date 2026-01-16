import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/size_config.dart';

class AuthPasswordRequirementItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool isChecked;
  final bool isDark;

  const AuthPasswordRequirementItem({
    super.key,
    required this.icon,
    required this.text,
    required this.isChecked,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: SizeConfig.blockWidth * 5,
          color: isChecked ? AppColors.successColor : AppColors.darkTextTertiary,
        ),
        SizedBox(width: SizeConfig.blockWidth * 3),
        Text(
          text,
          style: TextStyle(
            color: isChecked
                ? (isDark
                    ? AppColors.darkTextSecondary
                    : AppColors.lightTextSecondary)
                : (isDark
                    ? AppColors.darkTextTertiary
                    : AppColors.lightTextTertiary),
            fontSize: SizeConfig.blockWidth * 3.6,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}