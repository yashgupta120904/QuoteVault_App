import 'package:flutter/material.dart';
import 'package:quotevault/core/utils/size_config.dart';

import '../../../../core/constants/app_colors.dart';

class EmptyState extends StatelessWidget {
  final bool hasSearchQuery;
  final VoidCallback onExploreTap;

  const EmptyState({
    Key? key,
    required this.hasSearchQuery,
    required this.onExploreTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_outline,
            size: SizeConfig.blockWidth * 20,
            color: (Theme.of(context).brightness == Brightness.dark
                    ? AppColors.darkTextSecondary
                    : AppColors.lightTextSecondary)
                .withOpacity(0.3),
          ),
          SizedBox(height: SizeConfig.blockHeight * 2),
          Text(
            hasSearchQuery ? 'No Results Found' : 'No Favorites Yet',
            style: TextStyle(
              fontSize: SizeConfig.blockWidth * 5.5,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).brightness == Brightness.dark
                  ? AppColors.darkTextPrimary
                  : AppColors.lightTextPrimary,
            ),
          ),
          SizedBox(height: SizeConfig.blockHeight * 1),
          Text(
            hasSearchQuery
                ? 'Try searching with different keywords'
                : 'Add your favorite quotes to see them here',
            style: TextStyle(
              fontSize: SizeConfig.blockWidth * 3.2,
              color: Theme.of(context).brightness == Brightness.dark
                  ? AppColors.darkTextSecondary
                  : AppColors.lightTextSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: SizeConfig.blockHeight * 3),
          GestureDetector(
            onTap: onExploreTap,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.blockWidth * 6,
                vertical: SizeConfig.blockHeight * 1.2,
              ),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(SizeConfig.blockWidth * 2),
              ),
              child: Text(
                'Explore Quotes',
                style: TextStyle(
                  fontSize: SizeConfig.blockWidth * 3.5,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}