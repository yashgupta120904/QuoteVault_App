import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/size_config.dart';

class AuthorCard extends StatelessWidget {
  final String name;
  final String category;
  final String image;
  final VoidCallback? onTap;

  const AuthorCard({
    super.key,
    required this.name,
    required this.category,
    required this.image,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.darkSurfaceLight,
          borderRadius: BorderRadius.circular(SizeConfig.blockWidth * 4),
          border: Border.all(color: AppColors.darkBorder.withOpacity(0.4)),
        ),
        padding: EdgeInsets.all(SizeConfig.blockWidth * 2),
        child: Column(
          children: [
            /// 👤 Circular Avatar
            CircleAvatar(
              radius: SizeConfig.blockWidth * 12,
              backgroundColor: AppColors.primaryColor.withOpacity(0.15),
              child: Text(
                image,
                style: TextStyle(fontSize: SizeConfig.blockWidth * 8),
              ),
            ),
             SizedBox(height: SizeConfig.blockHeight * 0.5),

            

            Text(
              name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: SizeConfig.blockWidth * 3.8,
                fontWeight: FontWeight.bold,
                color: AppColors.darkTextPrimary,
              ),
            ),

            SizedBox(height: SizeConfig.blockHeight * 0.5),

            Text(
              category,
              style: TextStyle(
                fontSize: SizeConfig.blockWidth * 3,
                color: AppColors.darkTextSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
