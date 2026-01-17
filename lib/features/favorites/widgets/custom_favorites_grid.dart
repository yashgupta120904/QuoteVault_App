import 'package:flutter/material.dart';
import 'package:quotevault/core/constants/app_colors.dart';

import '../../../core/utils/size_config.dart';
import '../../quotes/data/models/quote_model.dart';

class GridQuoteCard extends StatelessWidget {
  final Quote quote;

  const GridQuoteCard({Key? key, required this.quote}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (quote.isImageQuote) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(SizeConfig.blockWidth * 3),
          border: Border.all(
            color: Theme.of(context).brightness == Brightness.dark
                ? AppColors.darkBorder
                : Colors.grey[300]!,
          ),
          image: const DecorationImage(
            image: NetworkImage(
              'https://lh3.googleusercontent.com/aida-public/AB6AXuDWP-P4v8lRt9QjpjaInL6WWqcrpRbAS8dNZAk20DBPculFSY53fG55DbstT668ujoN-k1xolh6P8c6IDGBGgzeRO_tjCrt85BUGNyz0oFj4u6tmwAkhOSYUtm0hTKQnfvcRQdppZFWzHptyG4dXK3asOHrQLjhL-l0bJHkymsz4Bb4hmDRDvpUEGcLcjmXVsizgVrC-cNGsnvRJQ2PUyHY1a6GaSo46Og4_Pl4NhOMkDaymteejlUWpfMEAAIGYZnkNmC84E9-mada',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(SizeConfig.blockWidth * 3),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.2),
                Colors.black.withOpacity(0.8),
              ],
            ),
          ),
          padding: EdgeInsets.all(SizeConfig.blockWidth * 3),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.favorite,
                    color: Colors.white,
                    size: SizeConfig.blockWidth * 5,
                  ),
                  Icon(
                    Icons.format_quote,
                    color: Colors.white30,
                    size: SizeConfig.blockWidth * 5,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    quote.text,
                    style: TextStyle(
                      fontSize: SizeConfig.blockWidth * 3.2,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.4,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: SizeConfig.blockHeight * 1),
                  Text(
                    quote.author.toUpperCase(),
                    style: TextStyle(
                      fontSize: SizeConfig.blockWidth * 2.2,
                      fontWeight: FontWeight.w600,
                      color: Colors.white70,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? AppColors.darkBg
            : Colors.white,
        borderRadius: BorderRadius.circular(SizeConfig.blockWidth * 3),
        border: Border.all(
          color: Theme.of(context).brightness == Brightness.dark
              ? AppColors.darkBorder
              : Colors.grey[300]!,
        ),
      ),
      padding: EdgeInsets.all(SizeConfig.blockWidth * 3),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.favorite,
                color: AppColors.primaryColor,
                size: SizeConfig.blockWidth * 5,
              ),
              Icon(
                Icons.format_quote,
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppColors.darkTextSecondary
                    : AppColors.lightTextSecondary,
                size: SizeConfig.blockWidth * 5,
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                quote.text,
                style: TextStyle(
                  fontSize: SizeConfig.blockWidth * 3.2,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? AppColors.darkTextPrimary
                      : AppColors.lightTextPrimary,
                  height: 1.4,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: SizeConfig.blockHeight * 1),
              Text(
                quote.author.toUpperCase(),
                style: TextStyle(
                  fontSize: SizeConfig.blockWidth * 2.2,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? AppColors.darkTextSecondary
                      : AppColors.lightTextSecondary,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}