
import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../navigation/scaffold_messenger_key.dart';
import 'size_config.dart';

enum SnackbarType { success, error, info }

/// ------------------------------------------------------------
/// SHOW SNACKBAR (THEME SAFE)
/// ------------------------------------------------------------
void showCustomSnackbar({
  required SnackbarType type,
  required String title,
  required String message,
  Duration duration = const Duration(seconds: 2),
}) {
  final messenger = scaffoldMessengerKey.currentState;
  if (messenger == null) return;

  WidgetsBinding.instance.addPostFrameCallback((_) {
    messenger.showSnackBar(
      SnackBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        duration: duration,
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.blockWidth * 4,
          vertical: SizeConfig.blockHeight * 1.2,
        ),
        content: _CustomSnackbar(
          type: type,
          title: title,
          message: message,
        ),
      ),
    );
  });
}

/// ------------------------------------------------------------
/// CUSTOM SNACKBAR WIDGET
/// ------------------------------------------------------------
class _CustomSnackbar extends StatelessWidget {
  final SnackbarType type;
  final String title;
  final String message;

  const _CustomSnackbar({
    required this.type,
    required this.title,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    /// 🔥 ALWAYS CORRECT THEME
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final bgColor =
        isDark ? AppColors.darkSurfaceLight : AppColors.lightSurfaceLight;

    final accentColor = switch (type) {
      SnackbarType.success => AppColors.successColor,
      SnackbarType.error => AppColors.errorColor,
      SnackbarType.info => AppColors.infoColor,
    };

    final icon = switch (type) {
      SnackbarType.success => Icons.check_circle_rounded,
      SnackbarType.error => Icons.cancel_rounded,
      SnackbarType.info => Icons.info_rounded,
    };

    return Container(
      padding: EdgeInsets.all(SizeConfig.blockWidth * 3),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        border: Border(
          left: BorderSide(color: accentColor, width: 4),
        ),
        boxShadow: [
          BoxShadow(
            color: accentColor.withOpacity(0.75),
            offset: const Offset(0, 2),
            blurRadius: 4,
            spreadRadius: -1,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: SizeConfig.blockHeight * 7,
            child: Center(
              child: Icon(
                icon,
                color: accentColor,
                size: SizeConfig.blockWidth * 6,
              ),
            ),
          ),
          SizedBox(width: SizeConfig.blockWidth * 2),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: SizeConfig.blockWidth * 3.8,
                    fontWeight: FontWeight.w600,
                    color: isDark
                        ? AppColors.darkTextPrimary
                        : AppColors.lightTextPrimary,
                  ),
                ),
                SizedBox(height: SizeConfig.blockHeight * 0.6),
                Text(
                  message,
                  style: TextStyle(
                    fontSize: SizeConfig.blockWidth * 3.2,
                    color: isDark
                        ? AppColors.darkTextSecondary
                        : AppColors.lightTextSecondary,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: SizeConfig.blockHeight * 0.15,
            ),
            child: GestureDetector(
              onTap: () =>
                  ScaffoldMessenger.of(context).hideCurrentSnackBar(),
              child: Icon(
                Icons.close,
                size: SizeConfig.blockWidth * 5,
                color: isDark
                    ? AppColors.darkTextTertiary
                    : AppColors.lightTextTertiary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

