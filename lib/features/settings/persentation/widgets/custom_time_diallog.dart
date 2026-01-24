// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import '../../../../core/constants/app_colors.dart';
// import '../../../../core/utils/size_config.dart';

// class CustomTimeDialog extends StatefulWidget {
//   final String initialTime;
//   final ValueChanged<String> onConfirm;
//   final bool isDark;

//   const CustomTimeDialog({
//     super.key,
//     required this.initialTime,
//     required this.onConfirm,
//     required this.isDark,
//   });

//   @override
//   State<CustomTimeDialog> createState() => _CustomTimeDialogState();
// }

// class _CustomTimeDialogState extends State<CustomTimeDialog> {
//   late int hour;
//   late int minute;
//   late bool isAm;

//   @override
//   void initState() {
//     super.initState();
//     final parts = widget.initialTime.split(RegExp(r'[: ]'));
//     hour = int.parse(parts[0]) % 12;
//     hour = hour == 0 ? 12 : hour;
//     minute = int.parse(parts[1]);
//     isAm = parts[2] == 'AM';
//   }

//   String _formatted() {
//     return '${hour.toString().padLeft(2, '0')}:'
//         '${minute.toString().padLeft(2, '0')} '
//         '${isAm ? 'AM' : 'PM'}';
//   }

//   Widget _buildPicker({
//     required int itemCount,
//     required int initialItem,
//     required ValueChanged<int> onSelected,
//     required String Function(int) labelBuilder,
//   }) {
//     return SizedBox(
//       width: SizeConfig.blockWidth * 20,
//       height: SizeConfig.blockHeight * 18,
//       child: CupertinoPicker(
//         scrollController:
//             FixedExtentScrollController(initialItem: initialItem),
//         itemExtent: SizeConfig.blockHeight * 4,
//         onSelectedItemChanged: onSelected,
//         children: List.generate(
//           itemCount,
//           (index) => Center(
//             child: Text(
//               labelBuilder(index),
//               style: TextStyle(
//                 fontSize: SizeConfig.blockWidth * 4,
//                 color: widget.isDark
//                     ? AppColors.darkTextPrimary
//                     : AppColors.lightTextPrimary,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       backgroundColor: widget.isDark
//           ? AppColors.darkSurfaceLight
//           : AppColors.lightSurfaceLight,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(SizeConfig.blockWidth * 4),
//       ),
//       child: Padding(
//         padding: EdgeInsets.all(SizeConfig.blockWidth * 4),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text(
//               'Select Reminder Time',
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: SizeConfig.blockWidth * 4,
//                 color: widget.isDark
//                     ? AppColors.darkTextPrimary
//                     : AppColors.lightTextPrimary,
//               ),
//             ),

//             SizedBox(height: SizeConfig.blockHeight * 2),

//             /// 🔥 Selected Time Preview
//             Text(
//               _formatted(),
//               style: TextStyle(
//                 fontSize: SizeConfig.blockWidth * 6,
//                 color: AppColors.primaryColor,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),

//             SizedBox(height: SizeConfig.blockHeight * 3),

//             /// ⏰ Time Dialers
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 /// Hour Picker
//                 _buildPicker(
//                   itemCount: 12,
//                   initialItem: hour - 1,
//                   onSelected: (val) {
//                     setState(() => hour = val + 1);
//                   },
//                   labelBuilder: (i) => (i + 1).toString().padLeft(2, '0'),
//                 ),

//                 const Text(":"),

//                 /// Minute Picker
//                 _buildPicker(
//                   itemCount: 60,
//                   initialItem: minute,
//                   onSelected: (val) {
//                     setState(() => minute = val);
//                   },
//                   labelBuilder: (i) => i.toString().padLeft(2, '0'),
//                 ),

//                 /// AM / PM Picker
//                 _buildPicker(
//                   itemCount: 2,
//                   initialItem: isAm ? 0 : 1,
//                   onSelected: (val) {
//                     setState(() => isAm = val == 0);
//                   },
//                   labelBuilder: (i) => i == 0 ? 'AM' : 'PM',
//                 ),
//               ],
//             ),

//             SizedBox(height: SizeConfig.blockHeight * 3),

//             /// ✅ Confirm Button
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: AppColors.primaryColor,
//                 padding: EdgeInsets.symmetric(
//                   horizontal: SizeConfig.blockWidth * 8,
//                   vertical: SizeConfig.blockHeight * 1.2,
//                 ),
//               ),
//               onPressed: () {
//                 widget.onConfirm(_formatted());
//                 Navigator.pop(context);
//               },
//               child: const Text('OK'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/cupertino.dart';
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
    hour = hour == 0 ? 12 : hour;
    minute = int.parse(parts[1]);
    isAm = parts[2] == 'AM';
  }

  String _formatted() {
    return '${hour.toString().padLeft(2, '0')}:'
        '${minute.toString().padLeft(2, '0')} '
        '${isAm ? 'AM' : 'PM'}';
  }

  Widget _buildPicker({
    required int itemCount,
    required int initialItem,
    required ValueChanged<int> onSelected,
    required String Function(int) labelBuilder,
  }) {
    return SizedBox(
      width: SizeConfig.blockWidth * 20,
      height: SizeConfig.blockHeight * 18,
      child: CupertinoPicker(
        scrollController:
            FixedExtentScrollController(initialItem: initialItem),
        itemExtent: SizeConfig.blockHeight * 4,
        onSelectedItemChanged: onSelected,
        children: List.generate(
          itemCount,
          (index) => Center(
            child: Text(
              labelBuilder(index),
              style: TextStyle(
                fontSize: SizeConfig.blockWidth * 4,
                color: widget.isDark
                    ? AppColors.darkTextPrimary
                    : AppColors.lightTextPrimary,
              ),
            ),
          ),
        ),
      ),
    );
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildPicker(
                  itemCount: 12,
                  initialItem: hour - 1,
                  onSelected: (val) => setState(() => hour = val + 1),
                  labelBuilder: (i) =>
                      (i + 1).toString().padLeft(2, '0'),
                ),
                const Text(":"),
                _buildPicker(
                  itemCount: 60,
                  initialItem: minute,
                  onSelected: (val) => setState(() => minute = val),
                  labelBuilder: (i) =>
                      i.toString().padLeft(2, '0'),
                ),
                _buildPicker(
                  itemCount: 2,
                  initialItem: isAm ? 0 : 1,
                  onSelected: (val) =>
                      setState(() => isAm = val == 0),
                  labelBuilder: (i) => i == 0 ? 'AM' : 'PM',
                ),
              ],
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
