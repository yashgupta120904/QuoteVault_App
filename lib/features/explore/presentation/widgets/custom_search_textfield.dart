// // import 'package:flutter/material.dart';
// // import '../../../../core/constants/app_colors.dart';
// // import '../../../../core/utils/size_config.dart';

// // class SearchTextField extends StatelessWidget {
// //   final TextEditingController? controller;
// //   final ValueChanged<String>? onChanged;
// //   final String hintText;

// //   const SearchTextField({
// //     super.key,
// //     this.controller,
// //     this.onChanged,
// //     this.hintText = 'Search by keyword, author, or book...',
// //   });

// //   @override
// //   Widget build(BuildContext context) {
// //     return Padding(
// //       padding: EdgeInsets.symmetric(
// //         horizontal: SizeConfig.blockWidth * 4,
// //         vertical: SizeConfig.blockHeight * 1,
// //       ),
// //       child: Container(
// //         height: SizeConfig.blockHeight * 6,
// //         decoration: BoxDecoration(
// //           color: AppColors.darkSurfaceLight,
// //           borderRadius: BorderRadius.circular(SizeConfig.blockWidth * 4),
// //         ),
// //         child: Row(
// //           children: [
// //             SizedBox(width: SizeConfig.blockWidth * 4),
// //             Icon(
// //               Icons.search,
// //               color: AppColors.darkTextSecondary,
// //               size: 24,
// //             ),
// //             SizedBox(width: SizeConfig.blockWidth * 3),
// //             Expanded(
// //               child: TextField(
// //                 controller: controller,
// //                 onChanged: onChanged,
// //                 style: TextStyle(
// //                   color: AppColors.darkTextPrimary,
// //                   fontSize: SizeConfig.blockWidth * 3.5,
// //                 ),
// //                 decoration: InputDecoration(
// //                   hintText: hintText,
// //                   hintStyle: TextStyle(
// //                     color: AppColors.darkTextSecondary,
// //                     fontSize: SizeConfig.blockWidth * 3.5,
// //                   ),
// //                   border: InputBorder.none,
// //                   contentPadding: EdgeInsets.zero,
// //                 ),
// //               ),
// //             ),
// //             SizedBox(width: SizeConfig.blockWidth * 4),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';

// import '../../../../core/constants/app_colors.dart';
// import '../../../../core/utils/size_config.dart';

// class SearchTextField extends StatelessWidget {
//   final TextEditingController? controller;
//   final ValueChanged<String>? onChanged;
//   final String hintText;

//   const SearchTextField({
//     super.key,
//     this.controller,
//     this.onChanged,
//     this.hintText = 'Search by keyword, author, or book...',
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(
//         horizontal: SizeConfig.blockWidth * 3,
     
//       ),
//       child: Row(
//         children: [
             
             
       
//           Expanded(
//             child: TextField(
//               controller: controller,
//               onChanged: onChanged,
//               style: TextStyle(
//                 color: AppColors.darkTextPrimary,
//                 fontSize: SizeConfig.blockWidth * 3.5,
//               ),
//               decoration: InputDecoration(
//                 hintText: hintText,
//                 hintStyle: TextStyle(
//                   color: AppColors.darkTextSecondary,
//                   fontSize: SizeConfig.blockWidth * 3.5,
//                 ),
//                 border: InputBorder.none,
//                 contentPadding: EdgeInsets.zero,
//                 prefixIcon: const Icon(Icons.search)
//               ),
//             ),
//           ),
            
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/size_config.dart';

class SearchTextField extends StatelessWidget {
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final String hintText;

  const SearchTextField({
    super.key,
    this.controller,
    this.onChanged,
    this.hintText = 'Search by keyword, author, or book...',
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.blockWidth * 3,
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: TextStyle(
          color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
          fontSize: SizeConfig.blockWidth * 3.5,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
            fontSize: SizeConfig.blockWidth * 3.5,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
          prefixIcon: Icon(
            Icons.search,
            color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
          ),
        ),
      ),
    );
  }
}