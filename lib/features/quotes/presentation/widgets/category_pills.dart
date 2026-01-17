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
                borderRadius: BorderRadius.circular(SizeConfig.blockWidth * 5),
                color: isSelected
                    ? AppColors.primaryColor
                    : AppColors.darkSurfaceLight,
                border: Border.all(
                  color: isSelected
                      ? AppColors.primaryColor
                      : AppColors.darkBorder,
                  width: 1,
                ),
              ),
              child: Text(
                categories[index],
                style: TextStyle(
                  fontSize: SizeConfig.blockWidth * 3,
                  fontWeight: FontWeight.w600,
                  color: isSelected
                      ? AppColors.darkTextPrimary
                      : AppColors.darkTextSecondary,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
