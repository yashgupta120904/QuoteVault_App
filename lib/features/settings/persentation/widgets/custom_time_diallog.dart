import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/size_config.dart';

class CustomTimeDialog extends StatefulWidget {
  final String initialTime;
  final ValueChanged<String> onConfirm;
  final bool isDark;

  const CustomTimeDialog({
    super.key,
    required this.initialTime,
    required this.onConfirm,
    required this.isDark,
  });

  @override
  State<CustomTimeDialog> createState() => _CustomTimeDialogState();
}

class _CustomTimeDialogState extends State<CustomTimeDialog> {
  late int hour;
  late int minute;
  late bool isAm;

  @override
  void initState() {
    super.initState();
    final parts = widget.initialTime.split(RegExp(r'[: ]'));
    hour = int.parse(parts[0]) % 12;
    minute = int.parse(parts[1]);
    isAm = parts[2] == 'AM';
  }

  String _formatted() {
    final h = hour == 0 ? 12 : hour;
    return '${h.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} ${isAm ? 'AM' : 'PM'}';
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: widget.isDark
          ? AppColors.darkSurfaceLight
          : AppColors.lightSurfaceLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(SizeConfig.blockWidth * 4),
      ),
      child: Padding(
        padding: EdgeInsets.all(SizeConfig.blockWidth * 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Select Reminder Time',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: SizeConfig.blockWidth * 4,
                color: widget.isDark
                    ? AppColors.darkTextPrimary
                    : AppColors.lightTextPrimary,
              ),
            ),
            SizedBox(height: SizeConfig.blockHeight * 2),
            Text(
              _formatted(),
              style: TextStyle(
                fontSize: SizeConfig.blockWidth * 6,
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: SizeConfig.blockHeight * 3),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
              ),
              onPressed: () {
                widget.onConfirm(_formatted());
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      ),
    );
  }
}
