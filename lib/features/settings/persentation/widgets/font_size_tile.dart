import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/size_config.dart';

class FontSizeTile extends StatelessWidget {
  final double fontSize;
  final ValueChanged<double> onChanged;
  final bool isDark;

  const FontSizeTile({
    super.key,
    required this.fontSize,
    required this.onChanged,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(SizeConfig.blockWidth * 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: SizeConfig.blockWidth * 8,
                    height: SizeConfig.blockWidth * 8,
                    decoration: BoxDecoration(
                      color: AppColors.accentOrange.withOpacity(0.15),
                      borderRadius:
                          BorderRadius.circular(SizeConfig.blockWidth * 2),
                    ),
                    child: Icon(
                      Icons.text_fields,
                      color: AppColors.accentOrange,
                      size: SizeConfig.blockWidth * 4,
                    ),
                  ),
                  SizedBox(width: SizeConfig.blockWidth * 3),
                  Text(
                    'Font Size',
                    style: TextStyle(
                      fontSize: SizeConfig.blockWidth * 3.8,
                      color: isDark
                          ? AppColors.darkTextPrimary
                          : AppColors.lightTextPrimary,
                    ),
                  ),
                ],
              ),
              Text(
                '${fontSize.toInt()}px',
                style: TextStyle(
                  fontSize: SizeConfig.blockWidth * 3,
                  color: isDark
                      ? AppColors.darkTextSecondary
                      : AppColors.lightTextSecondary,
                ),
              ),
            ],
          ),

          SizedBox(height: SizeConfig.blockHeight * 1.5),

          // Slider
          Row(
            children: [
              Text(
                'A',
                style: TextStyle(
                  fontSize: SizeConfig.blockWidth * 3,
                  color: isDark
                      ? AppColors.darkTextTertiary
                      : AppColors.lightTextTertiary,
                ),
              ),
              SizedBox(width: SizeConfig.blockWidth * 2),
              Expanded(
                child: SliderTheme(
                  data: SliderThemeData(
                    trackHeight: SizeConfig.blockHeight * 0.5,
                    thumbShape: RoundSliderThumbShape(
                      enabledThumbRadius:
                          SizeConfig.blockWidth * 2,
                    ),
                  ),
                  child: Slider(
                    value: fontSize,
                    min: 12,
                    max: 24,
                    divisions: 12,
                    activeColor: AppColors.primaryColor,
                    inactiveColor: isDark
                        ? AppColors.darkSurfaceLight
                        : AppColors.lightSurfaceDark,
                    onChanged: onChanged,
                  ),
                ),
              ),
              SizedBox(width: SizeConfig.blockWidth * 2),
              Text(
                'A',
                style: TextStyle(
                  fontSize: SizeConfig.blockWidth * 4,
                  color: isDark
                      ? AppColors.darkTextSecondary
                      : AppColors.lightTextSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
