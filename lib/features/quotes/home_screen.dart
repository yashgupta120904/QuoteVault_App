import 'package:flutter/material.dart';
import 'package:quotevault/core/constants/app_colors.dart';
import 'package:quotevault/core/utils/size_config.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, String>> quotes = [
    {
      'quote': 'The only way to do great work is to love what you do.',
      'author': 'Steve Jobs',
    },
    {
      'quote': 'Innovation distinguishes between a leader and a follower.',
      'author': 'Steve Jobs',
    },
    {
      'quote': 'Life is what happens when you\'re busy making other plans.',
      'author': 'John Lennon',
    },
    {
      'quote':
          'The future belongs to those who believe in the beauty of their dreams.',
      'author': 'Eleanor Roosevelt',
    },
    {
      'quote':
          'It is during our darkest moments that we must focus to see the light.',
      'author': 'Aristotle',
    },
  ];

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            /// App Bar
            SliverAppBar(
              pinned: true,
              elevation: 0,
              backgroundColor:
                  isDark ? AppColors.darkBg : AppColors.lightBg,
              title: Text(
                'QuoteVault',
                style: TextStyle(
                  color: isDark
                      ? AppColors.darkTextPrimary
                      : AppColors.lightTextPrimary,
                  fontSize: SizeConfig.blockWidth * 6,
                  fontWeight: FontWeight.w700,
                ),
              ),
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: SizeConfig.blockWidth * 4),
                  child: Center(
                    child: CircleAvatar(
                      radius: SizeConfig.blockWidth * 5,
                      backgroundColor: AppColors.primaryColor,
                      child: Icon(
                        Icons.person_outlined,
                        color: Colors.white,
                        size: SizeConfig.blockWidth * 5,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            /// Content
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.blockWidth * 6,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: SizeConfig.blockHeight * 2),

                    /// Welcome Section
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Good Morning',
                          style: TextStyle(
                            color: isDark
                                ? AppColors.darkTextSecondary
                                : AppColors.lightTextSecondary,
                            fontSize: SizeConfig.blockWidth * 3.8,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: SizeConfig.blockHeight * 0.5),
                        Text(
                          'Welcome back to your inspiration hub',
                          style: TextStyle(
                            color: isDark
                                ? AppColors.darkTextPrimary
                                : AppColors.lightTextPrimary,
                            fontSize: SizeConfig.blockWidth * 4.5,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: SizeConfig.blockHeight * 2.5),

                    /// Search Bar
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.blockWidth * 4,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color:
                            isDark ? AppColors.darkBg : AppColors.accentRed,
                        border: Border.all(
                          color: isDark
                              ? AppColors.darkBorder
                              : AppColors.lightBorder,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.search_outlined,
                            color: isDark
                                ? AppColors.darkTextSecondary
                                : AppColors.lightTextSecondary,
                          ),
                          SizedBox(width: SizeConfig.blockWidth * 3),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Search quotes...',
                                hintStyle: TextStyle(
                                  color: isDark
                                      ? AppColors.darkTextTertiary
                                      : AppColors.lightTextTertiary,
                                ),
                                border: InputBorder.none,
                              ),
                              style: TextStyle(
                                color: isDark
                                    ? AppColors.darkTextPrimary
                                    : AppColors.lightTextPrimary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: SizeConfig.blockHeight * 2.5),

                    /// Featured Quote
                    Text(
                      'Quote of the Day',
                      style: TextStyle(
                        color: isDark
                            ? AppColors.darkTextPrimary
                            : AppColors.lightTextPrimary,
                        fontSize: SizeConfig.blockWidth * 4.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: SizeConfig.blockHeight * 1.5),
                    Container(
                      padding: EdgeInsets.all(SizeConfig.blockWidth * 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primaryColor,
                            AppColors.primaryColor.withOpacity(0.8),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.format_quote_rounded,
                            color: Colors.white,
                            size: SizeConfig.blockWidth * 8,
                          ),
                          SizedBox(height: SizeConfig.blockHeight * 1.5),
                          Text(
                            quotes[0]['quote']!,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: SizeConfig.blockWidth * 4.2,
                              fontWeight: FontWeight.w600,
                              height: 1.5,
                            ),
                          ),
                          SizedBox(height: SizeConfig.blockHeight * 2),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              '— ${quotes[0]['author']}',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: SizeConfig.blockWidth * 3.8,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: SizeConfig.blockHeight * 3),

                    /// All Quotes Section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Recent Quotes',
                          style: TextStyle(
                            color: isDark
                                ? AppColors.darkTextPrimary
                                : AppColors.lightTextPrimary,
                            fontSize: SizeConfig.blockWidth * 4.5,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'View All',
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: SizeConfig.blockWidth * 3.5,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: SizeConfig.blockHeight * 1.5),
                  ],
                ),
              ),
            ),

            /// Quote List
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final quote = quotes[index];
                  return Padding(
                    padding: EdgeInsets.only(
                      left: SizeConfig.blockWidth * 6,
                      right: SizeConfig.blockWidth * 6,
                      bottom: SizeConfig.blockHeight * 1.5,
                    ),
                    child: Container(
                      padding: EdgeInsets.all(SizeConfig.blockWidth * 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color:
                            isDark ? AppColors.darkBg : AppColors.lightBg,
                        border: Border.all(
                          color: isDark
                              ? AppColors.darkBorder
                              : AppColors.lightBorder,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      quote['quote']!,
                                      style: TextStyle(
                                        color: isDark
                                            ? AppColors.darkTextPrimary
                                            : AppColors.lightTextPrimary,
                                        fontSize: SizeConfig.blockWidth * 3.8,
                                        fontWeight: FontWeight.w600,
                                        height: 1.4,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(
                                        height: SizeConfig.blockHeight * 1),
                                    Text(
                                      '— ${quote['author']}',
                                      style: TextStyle(
                                        color: isDark
                                            ? AppColors.darkTextSecondary
                                            : AppColors.lightTextSecondary,
                                        fontSize: SizeConfig.blockWidth * 3.5,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: SizeConfig.blockWidth * 3),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.favorite_outline,
                                  color: AppColors.primaryColor,
                                  size: SizeConfig.blockWidth * 5.5,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
                childCount: quotes.length,
              ),
            ),

            /// Bottom Padding
            SliverToBoxAdapter(
              child: SizedBox(height: SizeConfig.blockHeight * 2),
            ),
          ],
        ),
      ),
    );
  }
}
