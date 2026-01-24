import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/size_config.dart';

class CategoryPills extends StatelessWidget {
  final List<String> categories;
  final int selectedIndex;
  final ValueChanged<int>? onTap;

  const CategoryPills({
    super.key,
    required this.categories,
    this.selectedIndex = 0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      height: SizeConfig.blockHeight * 4,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) =>
            SizedBox(width: SizeConfig.blockWidth * 2),
        itemBuilder: (context, index) {
          final isSelected = index == selectedIndex;

          return GestureDetector(
            onTap: () => onTap?.call(index),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.blockWidth * 4,
                vertical: SizeConfig.blockHeight * 1,
              ),
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(SizeConfig.blockWidth * 5),
                color: isSelected
                    ? AppColors.primaryColor
                    : isDark
                        ? AppColors.darkSurfaceLight
                        : AppColors.lightSurfaceLight,
                border: Border.all(
                  color: isSelected
                      ? AppColors.primaryColor
                      : isDark
                          ? AppColors.darkBorder
                          : AppColors.lightBorder,
                  width: 1,
                ),
              ),
              child: Text(
                categories[index],
                style: TextStyle(
                  fontSize: SizeConfig.blockWidth * 3,
                  fontWeight: FontWeight.w600,
                  color: isSelected
                      ? Colors.white
                      : isDark
                          ? AppColors.darkTextSecondary
                          : AppColors.lightTextSecondary,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
