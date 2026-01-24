import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/size_config.dart';
import '../../../../core/services/wiki_service.dart';

class AuthorCard extends StatelessWidget {
  final String name;
  final String category;
  final String wikiKey;
  final VoidCallback? onTap;

  const AuthorCard({
    super.key,
    required this.name,
    required this.category,
    required this.wikiKey,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isDark
              ? AppColors.darkSurfaceLight
              : AppColors.lightSurfaceDark,
          borderRadius: BorderRadius.circular(SizeConfig.blockWidth * 4),
          border: Border.all(
            color: isDark
                ? AppColors.darkBorder.withOpacity(0.4)
                : AppColors.lightBorder.withOpacity(0.4),
          ),
        ),
        padding: EdgeInsets.all(SizeConfig.blockWidth * 2),
        child: Column(
          children: [
            /// 👤 Circular Avatar (Wiki Image + Fallback)
            FutureBuilder<String?>(
              future: WikiService.getAuthorImage(wikiKey),
              builder: (context, snapshot) {
                return CircleAvatar(
                  radius: SizeConfig.blockWidth * 10,
                  backgroundColor: AppColors.primaryColor.withOpacity(0.15),
                  backgroundImage: snapshot.data != null
                      ? NetworkImage(snapshot.data!)
                      : const AssetImage(
                          'assets/images/default_avatar.png',
                        ) as ImageProvider,
                );
              },
            ),

            SizedBox(height: SizeConfig.blockHeight * 0.8),

            /// 👤 Author Name
            Text(
              name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: SizeConfig.blockWidth * 3.8,
                fontWeight: FontWeight.bold,
                color: isDark
                    ? AppColors.darkTextPrimary
                    : AppColors.lightTextPrimary,
              ),
            ),

            SizedBox(height: SizeConfig.blockHeight * 0.4),

            /// 🏷 Category
            Text(
              category,
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
    );
  }
}
