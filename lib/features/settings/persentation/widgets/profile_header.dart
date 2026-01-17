// import 'package:flutter/material.dart';
// import '../../../../core/constants/app_colors.dart';
// import '../../../../core/utils/size_config.dart';

// // class ProfileHeader extends StatelessWidget {
// //   final bool isDark;
// //   final String name;
// //   final String email;
// //   final String imageUrl;
// //   final VoidCallback onTap;

// //   const ProfileHeader({
// //     super.key,
// //     required this.isDark,
// //     required this.name,
// //     required this.email,
// //     required this.imageUrl,
// //     required this.onTap,
// //   });

// //   @override
// //   Widget build(BuildContext context) {
// //     return GestureDetector(
// //       onTap: onTap,
// //       child: Padding(
// //         padding: EdgeInsets.all(SizeConfig.blockWidth * 4),
// //         child: Row(
// //           children: [
// //             Container(
// //               width: SizeConfig.blockWidth * 20,
// //               height: SizeConfig.blockWidth * 20,
// //               decoration: BoxDecoration(
// //                 shape: BoxShape.circle,
// //                 border: Border.all(
// //                   color: AppColors.primaryColor.withOpacity(0.3),
// //                   width: 2,
// //                 ),
// //                 image: DecorationImage(
// //                   image: NetworkImage(imageUrl),
// //                   fit: BoxFit.cover,
// //                 ),
// //               ),
// //             ),
// //             SizedBox(width: SizeConfig.blockWidth * 4),
// //             Expanded(
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   Text(
// //                     name,
// //                     style: TextStyle(
// //                       fontSize: SizeConfig.blockWidth * 4.5,
// //                       fontWeight: FontWeight.bold,
// //                       color: isDark
// //                           ? AppColors.darkTextPrimary
// //                           : AppColors.lightTextPrimary,
// //                     ),
// //                   ),
// //                   SizedBox(height: SizeConfig.blockHeight * 0.5),
// //                   Text(
// //                     email,
// //                     style: TextStyle(
// //                       fontSize: SizeConfig.blockWidth * 3,
// //                       color: isDark
// //                           ? AppColors.darkTextSecondary
// //                           : AppColors.lightTextSecondary,
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //             Icon(
// //               Icons.chevron_right,
// //               color: isDark
// //                   ? AppColors.darkTextTertiary
// //                   : AppColors.lightTextTertiary,
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import '../../../../core/constants/app_colors.dart';
// import '../../../../core/utils/size_config.dart';

// class ProfileHeader extends StatelessWidget {
//   final bool isDark;
//   final String name;
//   final String email;
//   final String imageUrl;
//   final VoidCallback onTap;

//   const ProfileHeader({
//     super.key,
//     required this.isDark,
//     required this.name,
//     required this.email,
//     required this.imageUrl,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.all(SizeConfig.blockWidth * 3),
//       child: GestureDetector(
//         onTap: onTap,
//         child: Container(
//           decoration: BoxDecoration(
//             color: isDark
//                 ? AppColors.darkSurfaceLight
//                 : AppColors.lightSurfaceLight,
//             borderRadius:
//                 BorderRadius.circular(SizeConfig.blockWidth * 3),
//             border: Border.all(
//               color: isDark
//                   ? AppColors.darkBorder.withOpacity(0.4)
//                   : AppColors.lightBorder,
//             ),
//           ),
//           padding: EdgeInsets.all(SizeConfig.blockWidth * 4),
//           child: Row(
//             children: [
//               // Avatar
//               Container(
//                 width: SizeConfig.blockWidth * 18,
//                 height: SizeConfig.blockWidth * 18,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   border: Border.all(
//                     color: AppColors.primaryColor.withOpacity(0.4),
//                     width: 2,
//                   ),
//                   image: DecorationImage(
//                     image: NetworkImage(imageUrl),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),

//               SizedBox(width: SizeConfig.blockWidth * 4),

//               // Name & Email
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       name,
//                       style: TextStyle(
//                         fontSize: SizeConfig.blockWidth * 4.5,
//                         fontWeight: FontWeight.bold,
//                         color: isDark
//                             ? AppColors.darkTextPrimary
//                             : AppColors.lightTextPrimary,
//                       ),
//                     ),
//                     SizedBox(height: SizeConfig.blockHeight * 0.5),
//                     Text(
//                       email,
//                       style: TextStyle(
//                         fontSize: SizeConfig.blockWidth * 3,
//                         color: isDark
//                             ? AppColors.darkTextSecondary
//                             : AppColors.lightTextSecondary,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               // Arrow
//               Icon(
//                 Icons.chevron_right,
//                 size: SizeConfig.blockWidth * 6,
//                 color: isDark
//                     ? AppColors.darkTextTertiary
//                     : AppColors.lightTextTertiary,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/size_config.dart';

class ProfileHeader extends StatelessWidget {
  final bool isDark;
  final String name;
  final String email;
  final String? imageUrl; // ✅ nullable
  final VoidCallback onTap;

  const ProfileHeader({
    super.key,
    required this.isDark,
    required this.name,
    required this.email,
    this.imageUrl, // ✅ optional
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(SizeConfig.blockWidth * 3),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: isDark
                ? AppColors.darkSurfaceLight
                : AppColors.lightSurfaceLight,
            borderRadius:
                BorderRadius.circular(SizeConfig.blockWidth * 3),
            border: Border.all(
              color: isDark
                  ? AppColors.darkBorder.withOpacity(0.4)
                  : AppColors.lightBorder,
            ),
          ),
          padding: EdgeInsets.all(SizeConfig.blockWidth * 4),
          child: Row(
            children: [
              // ================= AVATAR =================
              Container(
                width: SizeConfig.blockWidth * 18,
                height: SizeConfig.blockWidth * 18,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.primaryColor.withOpacity(0.4),
                    width: 2,
                  ),
                ),
                child: ClipOval(
                  child: _buildAvatar(),
                ),
              ),

              SizedBox(width: SizeConfig.blockWidth * 4),

              // ================= NAME & EMAIL =================
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: SizeConfig.blockWidth * 4.5,
                        fontWeight: FontWeight.bold,
                        color: isDark
                            ? AppColors.darkTextPrimary
                            : AppColors.lightTextPrimary,
                      ),
                    ),
                    SizedBox(height: SizeConfig.blockHeight * 0.5),
                    Text(
                      email,
                      style: TextStyle(
                        fontSize: SizeConfig.blockWidth * 3,
                        color: isDark
                            ? AppColors.darkTextSecondary
                            : AppColors.lightTextSecondary,
                      ),
                    ),
                  ],
                ),
              ),

              // ================= ARROW =================
              Icon(
                Icons.chevron_right,
                size: SizeConfig.blockWidth * 6,
                color: isDark
                    ? AppColors.darkTextTertiary
                    : AppColors.lightTextTertiary,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ================= AVATAR LOGIC =================
  Widget _buildAvatar() {
    if (imageUrl == null || imageUrl!.isEmpty) {
      return const Icon(
        Icons.person,
        color: Colors.white,
        size: 32,
      );
    }

    // Local file image
    if (!imageUrl!.startsWith('http')) {
      return Image.file(
        File(imageUrl!),
        fit: BoxFit.cover,
      );
    }

    // Network image
    return Image.network(
      imageUrl!,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => const Icon(Icons.person),
    );
  }
}

