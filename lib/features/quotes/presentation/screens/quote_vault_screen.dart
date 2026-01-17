import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quotevault/features/quotes/presentation/widgets/custom_search.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/size_config.dart';
import 'package:intl/intl.dart';

import '../widgets/category_pills.dart';
import '../widgets/quote_card.dart';

class QuoteVaultScreen extends StatefulWidget {
  const QuoteVaultScreen({super.key});

  @override
  State<QuoteVaultScreen> createState() => _QuoteVaultScreenState();
}

class _QuoteVaultScreenState extends State<QuoteVaultScreen> {
  final Map<int, bool> likedQuotes = {};
  int selectedCategoryIndex = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    SizeConfig.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.blockWidth * 4,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
              

                _buildFeaturedQuote(),
                SizedBox(height: SizeConfig.blockHeight * 2),

                /// ✅ CUSTOM CATEGORY PILLS
                CategoryPills(
                  categories: const ['All Topics', 'Mindfulness', 'Success'],
                  selectedIndex: selectedCategoryIndex,
                  onTap: (index) {
                    setState(() {
                      selectedCategoryIndex = index;
                    });
                  },
                ),

                SizedBox(height: SizeConfig.blockHeight * 2),

                _buildRecommendedSection(),
                SizedBox(height: SizeConfig.blockHeight * 1.5),

                /// ✅ CUSTOM QUOTE CARD
               QuoteCard(
  quote: "Act as if what you do makes a difference. It does.",
  author: "William James",
  genre: "Action",
  isLiked: true,
  onLike: () {},
  onShare: () {},
),


                SizedBox(height: SizeConfig.blockHeight * 1.5),

              QuoteCard(
  quote: "Act as if what you do makes a difference. It does.",
  author: "William James",
  genre: "Action",
  isLiked: true,
  onLike: () {},
  onShare: () {},
),


                SizedBox(height: SizeConfig.blockHeight * 1.5),

                /// ✅ CUSTOM IMAGE QUOTE CARD
               

                SizedBox(height: SizeConfig.blockHeight * 1.5),

              QuoteCard(
  quote: "Act as if what you do makes a difference. It does.",
  author: "William James",
  genre: "Action",
  isLiked: true,
  onLike: () {},
  onShare: () {},
),

                SizedBox(height: SizeConfig.blockHeight * 3),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ================= HEADER =================

 Widget _buildHeader() {
  final now = DateTime.now();
  final formattedDate =
      DateFormat('EEEE, MMMM d').format(now).toUpperCase();

  return Padding(
    padding: EdgeInsets.symmetric(vertical: SizeConfig.blockHeight * 2),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'QuoteVault',
              style: TextStyle(
                fontSize: SizeConfig.blockWidth * 6,
                fontWeight: FontWeight.bold,
                color: AppColors.darkTextPrimary,
              ),
            ),
            Text(
              formattedDate, // ✅ REAL DAY & DATE
              style: TextStyle(
                fontSize: SizeConfig.blockWidth * 2.5,
                fontWeight: FontWeight.w500,
                color: AppColors.darkTextSecondary,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
     SearchCircleButton(onTap: (){})
      ],
    ),
  );
}


  // ================= FEATURED QUOTE =================

  Widget _buildFeaturedQuote() {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(SizeConfig.blockWidth * 4),
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [AppColors.accentPurple, AppColors.primaryColor],
      ),
    ),
    child: Column(
      children: [
        // 🔮 Decorative circle (background glow)
        // Positioned(
        //   right: -SizeConfig.blockWidth * 6,
        //   bottom: -SizeConfig.blockWidth * 6,
        //   child: Container(
        //     width: SizeConfig.blockWidth * 30,
        //     height: SizeConfig.blockWidth* 30,
        //     decoration: BoxDecoration(
        //       shape: BoxShape.circle,
        //       color: AppColors.darkBg.withOpacity(0.2),
        //     ),
        //   ),
        // ),

        Padding(
          padding: EdgeInsets.all(SizeConfig.blockWidth * 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🟣 QUOTE OF THE DAY TAG
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.blockWidth * 3,
                  vertical: SizeConfig.blockHeight * 0.7,
                ),
                decoration: BoxDecoration(
                  color: AppColors.darkBg.withOpacity(0.5),
                  borderRadius:
                      BorderRadius.circular(SizeConfig.blockWidth * 1.5),
                ),
                child: Text(
                  'QUOTE OF THE DAY',
                  style: TextStyle(
                    fontSize: SizeConfig.blockWidth * 2.2,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFFE9D5FF),
                    letterSpacing: 0.5,
                  ),
                ),
              ),

              SizedBox(height: SizeConfig.blockHeight * 2),

              // ✨ QUOTE TEXT
              Text(
                '"The only way to do great work is to love what you do."',
                style: TextStyle(
                  fontSize: SizeConfig.blockWidth * 5,
                   fontStyle:FontStyle.italic,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  height: 1.4,
                ),
              ),

              SizedBox(height: SizeConfig.blockHeight * 2.5),

              // 👤 AUTHOR + ACTION ICONS
              Row(
               
                children: [
                   Text(
                    '—',
                    style: TextStyle(
                      fontSize: SizeConfig.blockWidth * 3.2,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFFE9D5FF),
                    ),
                  ),

                  Text(
                    ' Steve Jobs',
                    style: TextStyle(
                      fontSize: SizeConfig.blockWidth * 3.2,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFFE9D5FF),
                    ),
                  ),
                  SizedBox(width:SizeConfig.blockWidth * 36,),

                 
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.favorite_border_outlined,
                          size: SizeConfig.blockWidth * 4.5,
                        ),
                        color: AppColors.lightBg,
                        onPressed: () {},
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                      SizedBox(width: SizeConfig.blockWidth * 3),
                      IconButton(
                        icon: Icon(
                          CupertinoIcons.share,
                          size: SizeConfig.blockWidth * 4.5,
                        ),
                        color: AppColors.lightBg,
                        onPressed: () {},
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

  // ================= SECTION TITLE =================

  Widget _buildRecommendedSection() {
    return Text(
      'Recommended for you',
      style: TextStyle(
        fontSize: SizeConfig.blockWidth * 3.8,
        fontWeight: FontWeight.w600,
        color: AppColors.darkTextPrimary,
      ),
    );
  }
}
