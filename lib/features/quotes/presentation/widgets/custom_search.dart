import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/size_config.dart';
import '../../../explore/presentation/screens/explore_screen.dart';

class SearchCircleButton extends StatelessWidget {
  final VoidCallback? onTap;

  const SearchCircleButton({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap ?? () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const ExploreScreen(autoFocusSearch: true),
          ),
        );
      },
      child: Container(
        width: SizeConfig.blockWidth * 10,
        height: SizeConfig.blockWidth * 10,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isDark
              ? const Color.fromARGB(255, 44, 41, 71)
              : Colors.grey[200],
        ),
        child: Center(
          child: Icon(
            Icons.search,
            size: SizeConfig.blockWidth * 5,
            color: isDark
                ? AppColors.primaryColor
                : Colors.grey[700],
          ),
        ),
      ),
    );
  }
}