import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/size_config.dart';


class SearchCircleButton extends StatelessWidget {
  final VoidCallback onTap;

  const SearchCircleButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: SizeConfig.blockWidth * 10,
        height: SizeConfig.blockWidth * 10,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color.fromARGB(255, 44, 41, 71),
        ),
        child: Center(
          child: Icon(
            Icons.search,
            size: SizeConfig.blockWidth * 5,
            color: AppColors.primaryColor,
          ),
        ),
      ),
    );
  }
}
