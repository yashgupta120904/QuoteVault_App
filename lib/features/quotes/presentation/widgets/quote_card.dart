
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/size_config.dart';

class QuoteCard extends StatelessWidget {
  final String quote;
  final String author;
  final String genre;
  final bool isLiked;
  final Color accentColor;
  final VoidCallback onLike;
  final VoidCallback onShare;

  const QuoteCard({
    super.key,
    required this.quote,
    required this.author,
    required this.genre,
    required this.isLiked,
    required this.onLike,
    required this.onShare,
    this.accentColor = AppColors.accentGreen,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SizeConfig.blockWidth * 3),
        color: isDark
            ? AppColors.darkSurfaceLight
            : AppColors.lightSurfaceLight,
        border: Border.all(
          color: isDark
              ? AppColors.darkBorder
              : AppColors.lightBorder,
          width: 1,
        ),
      ),
      padding: EdgeInsets.all(SizeConfig.blockWidth * 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// QUOTE
          Text(
            '"$quote"',
            style: TextStyle(
              fontSize: SizeConfig.blockWidth * 4,
              fontWeight: FontWeight.w500,
              color: isDark
                  ? AppColors.darkTextPrimary
                  : AppColors.lightTextPrimary,
              height: 1.5,
              fontStyle: FontStyle.italic,
            ),
          ),

          SizedBox(height: SizeConfig.blockHeight * 1.2),

          /// AUTHOR
          Text(
            "- $author",
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontSize: SizeConfig.blockWidth * 2.8,
              fontWeight: FontWeight.w500,
              color: isDark
                  ? AppColors.darkTextSecondary
                  : AppColors.lightTextSecondary,
            ),
          ),

          SizedBox(height: SizeConfig.blockHeight * 1.5),

          /// GENRE + ACTIONS
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// GENRE PILL
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.blockWidth * 3,
                  vertical: SizeConfig.blockHeight * 0.5,
                ),
                decoration: BoxDecoration(
                  color: AppColors.accentPurple.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(
                    SizeConfig.blockWidth * 4,
                  ),
                ),
                child: Text(
                  genre,
                  style: TextStyle(
                    fontSize: SizeConfig.blockWidth * 2.4,
                    fontWeight: FontWeight.w600,
                    color: AppColors.accentPurple,
                  ),
                ),
              ),

              /// LIKE + SHARE
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      isLiked
                          ? Icons.favorite
                          : Icons.favorite_outline,
                      size: SizeConfig.blockWidth * 4,
                    ),
                    color: isLiked
                        ? AppColors.accentPurple
                        : AppColors.darkTextSecondary,
                    onPressed: onLike, // 🔥 Provider controls removal
                  ),

                  SizedBox(width: SizeConfig.blockWidth * 2),

                  IconButton(
                    icon: Icon(
                      CupertinoIcons.share,
                      size: SizeConfig.blockWidth * 4,
                    ),
                    color: AppColors.darkTextSecondary,
                    onPressed: onShare,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
