import 'package:flutter/material.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/utils/size_config.dart';

class EmptyVaultView extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onAction;

  const EmptyVaultView({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(SizeConfig.blockWidth * 6),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.bookmark_border,
              size: SizeConfig.blockWidth * 22,
              color: AppColors.darkTextTertiary,
            ),
            SizedBox(height: SizeConfig.blockHeight * 3),
            Text(
              title,
              style: TextStyle(
                fontSize: SizeConfig.blockWidth * 5.5,
                fontWeight: FontWeight.bold,
                color: AppColors.darkTextPrimary,
              ),
            ),
            SizedBox(height: SizeConfig.blockHeight * 1.5),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: SizeConfig.blockWidth * 3.5,
                color: AppColors.darkTextSecondary,
              ),
            ),
            SizedBox(height: SizeConfig.blockHeight * 4),
            ElevatedButton(
              onPressed: onAction,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accentPurple,
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.blockWidth * 6,
                  vertical: SizeConfig.blockHeight * 1.4,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(SizeConfig.blockWidth * 4),
                ),
              ),
              child: const Text('Explore Quotes'),
            ),
          ],
        ),
      ),
    );
  }
}
