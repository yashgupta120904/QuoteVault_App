import 'package:flutter/material.dart';
import 'package:quotevault/features/quotes/presentation/widgets/quote_card.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/size_config.dart';
import '../../../quotes/presentation/widgets/category_pills.dart';
import '../widgets/custom_author_card.dart';
import '../widgets/custom_search_textfield.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  int selectedCategory = 0;

  final categories = [
    'Wisdom',
    'Success',
    'Love',
    'Philosophy',
    'Life',
  ];

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🔍 Header
          Padding(
            padding: EdgeInsets.fromLTRB(
              SizeConfig.blockWidth * 4,
              SizeConfig.blockHeight * 5,
              SizeConfig.blockWidth * 4,
              SizeConfig.blockHeight * 2,
            ),
            child: Row(
              children: [
                const Icon(Icons.explore,
                    color: AppColors.darkTextPrimary, size: 28),
                SizedBox(width: SizeConfig.blockWidth * 2),
                Text(
                  'Explore',
                  style: TextStyle(
                    fontSize: SizeConfig.blockWidth * 7,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkTextPrimary,
                  ),
                ),
              ],
            ),
          ),

          /// 🔎 Search
          const SearchTextField(),

          /// 🏷 Categories
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.blockWidth * 4,
              vertical: SizeConfig.blockHeight * 2,
            ),
            child: CategoryPills(
              categories: categories,
              selectedIndex: selectedCategory,
              onTap: (i) => setState(() => selectedCategory = i),
            ),
          ),

          /// 🔥 Trending Authors
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.blockWidth * 4,
            ),
            child: Text(
              'Trending Authors',
              style: TextStyle(
                fontSize: SizeConfig.blockWidth * 4,
                fontWeight: FontWeight.bold,
                color: AppColors.darkTextPrimary,
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.all(SizeConfig.blockWidth * 4),
            child: Column(
              children: [
                const Row(
                  children:[
                    Expanded(
                      child: AuthorCard(
                        name: 'Marcus Aurelius',
                        category: 'Stoicism',
                        image: '👨‍🦱',
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: AuthorCard(
                        name: 'Maya Angelou',
                        category: 'Poetry',
                        image: '👩',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Row(
                  children: const [
                    Expanded(
                      child: AuthorCard(
                        name: 'Steve Jobs',
                        category: 'Innovation',
                        image: '👨‍💼',
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: AuthorCard(
                        name: 'Naval Ravikant',
                        category: 'Philosophy',
                        image: '👨‍🔬',
                      ),
                    ),
                  ],
                ),

                
              ],
            ),
          ),
             Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.blockWidth * 4,
            ),
            child: Text(
              'Quotes',
              style: TextStyle(
                fontSize: SizeConfig.blockWidth * 4,
                fontWeight: FontWeight.bold,
                color: AppColors.darkTextPrimary,
              ),
            ),
          ),

                 const SizedBox(height: 10),
             Padding(
               padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.blockWidth * 4,
            ),
               child: QuoteCard(
                 quote: "Act as if what you do makes a difference. It does.",
                 author: "William James",
                 genre: "Action",
                 isLiked: true,
                 onLike: () {},
                 onShare: () {},
               ),
             ),

          SizedBox(height: SizeConfig.blockHeight * 4),
        ],
      ),
    );
  }
}
