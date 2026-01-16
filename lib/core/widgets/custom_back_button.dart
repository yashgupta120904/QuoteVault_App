import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../utils/size_config.dart';

// class CustomCircularBackButton extends StatelessWidget {
//   final bool isDark;
//   final VoidCallback? onPressed;

//   const CustomCircularBackButton({
//     super.key,
//     required this.isDark,
//     this.onPressed,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(right: ),
//       child: Material(
//         color: isDark
//             ? AppColors.darkSurfaceLight
//             : AppColors.lightSurfaceLight,
//         shape: const CircleBorder(),
//         elevation: 0,
//         child: InkWell(
//           customBorder: const CircleBorder(),
//           onTap: onPressed ?? () => Navigator.pop(context),
//           child: Padding(
//             padding: EdgeInsets.all(SizeConfig.blockWidth * 2.5),
//             child: Icon(
//               Icons.arrow_back_ios_new,
//               size: SizeConfig.blockWidth * 4,
//               color: isDark
//                   ? AppColors.darkTextPrimary
//                   : AppColors.lightTextPrimary,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class CustomCircularBackButton extends StatelessWidget {
  final bool isDark;
  final VoidCallback? onPressed;

  const CustomCircularBackButton({
    super.key,
    required this.isDark,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isDark
            ? AppColors.darkSurfaceLight
            : AppColors.lightSurfaceDark,
        border: Border.all(
          color: isDark
              ? AppColors.darkBorder
              : AppColors.lightBorder,
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        shape: const CircleBorder(),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onPressed ?? () => Navigator.pop(context),
          child: Padding(
            padding: EdgeInsets.all(SizeConfig.blockWidth * 2.5),
            child: Icon(
              Icons.arrow_back_ios_new,
              size: SizeConfig.blockWidth * 4,
              color: isDark
                  ? AppColors.darkTextPrimary
                  : AppColors.lightTextPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
