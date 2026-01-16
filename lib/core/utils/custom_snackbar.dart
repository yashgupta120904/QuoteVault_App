import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../navigation/scaffold_messenger_key.dart';
import 'size_config.dart';

enum SnackbarType { success, error, info }

/// ------------------------------------------------------------
/// SHOW SNACKBAR
/// ------------------------------------------------------------
void showCustomSnackbar({
  
  required SnackbarType type,
  required String title,
  required String message,
  Duration duration = const Duration(seconds: 4),
}) {
    final messenger = scaffoldMessengerKey.currentState;
    if (messenger == null) return;

      final context = messenger.context;
    final isDark = Theme.of(context).brightness == Brightness.dark;

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
          isDark: isDark,
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
  final bool isDark;

  const _CustomSnackbar({
    required this.type,
    required this.title,
    required this.message,
    this.isDark = false,
  });

  Color get _bgColor =>
      isDark ? AppColors.darkSurfaceLight : AppColors.lightSurfaceLight;

  Color get _accentColor {
    switch (type) {
      case SnackbarType.success:
        return AppColors.successColor;
      case SnackbarType.error:
        return AppColors.errorColor;
      case SnackbarType.info:
        return AppColors.infoColor;
    }
  }

  IconData get _icon {
    switch (type) {
      case SnackbarType.success:
        return Icons.check_circle_rounded;
      case SnackbarType.error:
        return Icons.cancel_rounded;
      case SnackbarType.info:
        return Icons.info_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(SizeConfig.blockWidth * 3),
      decoration: BoxDecoration(
        color: _bgColor,
        borderRadius: BorderRadius.circular(12),
        border: Border(
          left: BorderSide(color: _accentColor, width: 4),
        ),

        /// 🔥 Bottom-only shadow
        boxShadow: [
          BoxShadow(
            color: _accentColor.withOpacity(0.8),
            offset: const Offset(0, 2),
            blurRadius: 3,
            spreadRadius: -1,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🔹 LEFT ICON (VERTICALLY CENTERED)
          SizedBox(
            height: SizeConfig.blockHeight * 7,
            child: Center(
              child: Icon(
                _icon,
                color: _accentColor,
                size: SizeConfig.blockWidth * 6,
              ),
            ),
          ),

          SizedBox(width: SizeConfig.blockWidth * 2),

          /// 🔹 TITLE + MESSAGE
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

          /// 🔹 CLOSE ICON (ALIGNED WITH TITLE)
          Padding(
            padding: EdgeInsets.only(
              top: SizeConfig.blockHeight * 0.15,
            ),
            child: GestureDetector(
              onTap: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
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
