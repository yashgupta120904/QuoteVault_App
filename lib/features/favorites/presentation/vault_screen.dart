import 'package:flutter/material.dart';
import 'package:quotevault/features/favorites/widgets/custom_favorites_grid.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/utils/size_config.dart';
import '../../explore/presentation/widgets/custom_search_textfield.dart';
import '../../quotes/data/models/quote_model.dart';
import '../../quotes/presentation/widgets/quote_card.dart';

// class VaultScreen extends StatefulWidget {
//   const VaultScreen({Key? key}) : super(key: key);

//   @override
//   State<VaultScreen> createState() => _VaultScreenState();
// }

// class _VaultScreenState extends State<VaultScreen> {
//   String searchQuery = '';
//   late List<Quote> filteredQuotes;

//   final List<Quote> quotes = [
//     Quote(
//       text: 'The only way to do great work is to love what you do.',
//       author: 'Steve Jobs',
//       genre: 'Motivation',
//       isFavorite: true,
//     ),
//     Quote(
//       text: 'Stay hungry, stay foolish.',
//       author: 'Steve Jobs',
//       genre: 'Wisdom',
//       isFavorite: true,
//     ),
//     Quote(
//       text: 'Nature does not hurry, yet everything is accomplished.',
//       author: 'Lao Tzu',
//       genre: 'Philosophy',
//       isFavorite: true,
//     ),
//     Quote(
//       text: 'Simplicity is the ultimate sophistication.',
//       author: 'Leonardo da Vinci',
//       genre: 'Design',
//       isFavorite: true,
//     ),
//     Quote(
//       text: 'What we think, we become.',
//       author: 'Buddha',
//       genre: 'Mindfulness',
//       isFavorite: true,
//     ),
//     Quote(
//       text: 'The best way to predict the future is to create it.',
//       author: 'Peter Drucker',
//       genre: 'Action',
//       isFavorite: true,
//     ),
//   ];

//   @override
//   void initState() {
//     super.initState();
//     filteredQuotes = quotes;
//   }

//   void _updateFilteredQuotes() {
//     setState(() {
//       if (searchQuery.isEmpty) {
//         filteredQuotes = quotes;
//       } else {
//         filteredQuotes = quotes.where((quote) {
//           return quote.text.toLowerCase().contains(searchQuery.toLowerCase()) ||
//               quote.author.toLowerCase().contains(searchQuery.toLowerCase()) ||
//               quote.genre.toLowerCase().contains(searchQuery.toLowerCase());
//         }).toList();
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     SizeConfig.init(context);
//     final isDark = Theme.of(context).brightness == Brightness.dark;

//     return Scaffold(
//       body: NestedScrollView(
//         headerSliverBuilder: (context, innerBoxIsScrolled) {
//           return [
//             SliverAppBar(
//               floating: true,
//               snap: true,
//               pinned: true,
//               elevation: 0,
//               backgroundColor: Colors.transparent,
//               title: Row(
//                 children: [
//                   Icon(
//                     Icons.favorite,
//                     color: AppColors.primaryColor,
//                     size: SizeConfig.blockWidth * 6,
//                   ),
//                   SizedBox(width: SizeConfig.blockWidth * 2),
//                   Text(
//                     'Your Favorites',
//                     style: TextStyle(
//                       fontSize: SizeConfig.blockWidth * 6,
//                       fontWeight: FontWeight.bold,
//                       color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
//                     ),
//                   ),
//                 ],
//               ),
//               actions: [
//                 IconButton(
//                   icon: Icon(
//                     isDark ? Icons.light_mode : Icons.dark_mode,
//                     color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
//                   ),
//                   onPressed: () {
//                     // Theme toggle handled by MyApp
//                   },
//                 ),
//               ],
//             ),
//           ];
//         },
//         body: SingleChildScrollView(
//           child: Column(
//             children: [
//               Padding(
//                 padding: EdgeInsets.symmetric(
//                   vertical: SizeConfig.blockHeight * 1.5,
//                 ),
//                 child: SearchTextField(
//                   hintText: 'Search your vault...',
//                   onChanged: (value) {
//                     searchQuery = value;
//                     _updateFilteredQuotes();
//                   },
//                 ),
//               ),
//               if (filteredQuotes.isEmpty)
//                 _buildEmptyState()
//               else
//                 Padding(
//                   padding: EdgeInsets.symmetric(
//                     horizontal: SizeConfig.blockWidth * 4,
//                     vertical: SizeConfig.blockHeight * 2,
//                   ),
//                   child: ListView.builder(
//                     shrinkWrap: true,
//                     physics: const NeverScrollableScrollPhysics(),
//                     itemCount: filteredQuotes.length,
//                     itemBuilder: (context, index) {
//                       return Padding(
//                         padding: EdgeInsets.only(
//                           bottom: SizeConfig.blockHeight * 1.5,
//                         ),
//                         child: QuoteCard(
//                           quote: filteredQuotes[index].text,
//                           author: filteredQuotes[index].author,
//                           genre: filteredQuotes[index].genre,
//                           isLiked: filteredQuotes[index].isFavorite,
//                           onLike: () {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(
//                                 content: Text(
//                                   'Quote ${filteredQuotes[index].isFavorite ? "unliked" : "liked"}',
//                                 ),
//                               ),
//                             );
//                           },
//                           onShare: () {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(
//                                 content: Text('Shared: ${filteredQuotes[index].text}'),
//                               ),
//                             );
//                           },
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               SizedBox(height: SizeConfig.blockHeight * 3),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildEmptyState() {
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//     return Center(
//       child: Padding(
//         padding: EdgeInsets.all(SizeConfig.blockWidth * 4),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             SizedBox(height: SizeConfig.blockHeight * 10),
//             Icon(
//               Icons.favorite_outline,
//               size: SizeConfig.blockWidth * 20,
//               color: (isDark
//                       ? AppColors.darkTextSecondary
//                       : AppColors.lightTextSecondary)
//                   .withOpacity(0.3),
//             ),
//             SizedBox(height: SizeConfig.blockHeight * 2),
//             Text(
//               searchQuery.isEmpty ? 'No Favorites Yet' : 'No Results Found',
//               style: TextStyle(
//                 fontSize: SizeConfig.blockWidth * 5.5,
//                 fontWeight: FontWeight.bold,
//                 color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
//               ),
//             ),
//             SizedBox(height: SizeConfig.blockHeight * 1),
//             Text(
//               searchQuery.isEmpty
//                   ? 'Add your favorite quotes to see them here'
//                   : 'Try searching with different keywords',
//               style: TextStyle(
//                 fontSize: SizeConfig.blockWidth * 3.2,
//                 color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
//               ),
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(height: SizeConfig.blockHeight * 3),
//             GestureDetector(
//               onTap: () {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(content: Text('Navigate to explore')),
//                 );
//               },
//               child: Container(
//                 padding: EdgeInsets.symmetric(
//                   horizontal: SizeConfig.blockWidth * 6,
//                   vertical: SizeConfig.blockHeight * 1.2,
//                 ),
//                 decoration: BoxDecoration(
//                   color: AppColors.primaryColor,
//                   borderRadius: BorderRadius.circular(SizeConfig.blockWidth * 2),
//                 ),
//                 child: Text(
//                   'Explore Quotes',
//                   style: TextStyle(
//                     fontSize: SizeConfig.blockWidth * 3.5,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

import '../widgets/empty_state.dart';

class VaultScreen extends StatefulWidget {
  const VaultScreen({Key? key}) : super(key: key);

  @override
  State<VaultScreen> createState() => _VaultScreenState();
}

class _VaultScreenState extends State<VaultScreen> {
  int currentIndex = 3;
  bool isGridView = true;
  String searchQuery = '';
  late List<Quote> filteredQuotes;

  final List<Quote> quotes = [
    Quote(
      text: 'The only way to do great work is to love what you do.',
      author: 'Steve Jobs',
      genre: 'Motivation',
      isFavorite: true,
    ),
    Quote(
      text: 'Stay hungry, stay foolish.',
      author: 'Steve Jobs',
      genre: 'Wisdom',
      isFavorite: true,
    ),
    Quote(
      text: 'Nature does not hurry, yet everything is accomplished.',
      author: 'Lao Tzu',
      genre: 'Philosophy',
      isFavorite: true,
      isImageQuote: true,
    ),
    Quote(
      text: 'Simplicity is the ultimate sophistication.',
      author: 'Leonardo da Vinci',
      genre: 'Design',
      isFavorite: true,
    ),
    Quote(
      text: 'What we think, we become.',
      author: 'Buddha',
      genre: 'Mindfulness',
      isFavorite: true,
    ),
    Quote(
      text: 'The best way to predict the future is to create it.',
      author: 'Peter Drucker',
      genre: 'Action',
      isFavorite: true,
    ),
  ];

  @override
  void initState() {
    super.initState();
    filteredQuotes = quotes;
  }

  void _updateFilteredQuotes() {
    setState(() {
      if (searchQuery.isEmpty) {
        filteredQuotes = quotes;
      } else {
        filteredQuotes = quotes.where((quote) {
          return quote.text.toLowerCase().contains(searchQuery.toLowerCase()) ||
              quote.author.toLowerCase().contains(searchQuery.toLowerCase()) ||
              quote.genre.toLowerCase().contains(searchQuery.toLowerCase());
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
           Padding(
            padding: EdgeInsets.fromLTRB(
              SizeConfig.blockWidth * 4,
              SizeConfig.blockHeight * 5,
              SizeConfig.blockWidth * 4,
              SizeConfig.blockHeight * 0,
            ),
            child: Row(
              children: [
                const Icon(Icons.favorite,
                    color: AppColors.darkTextPrimary, size: 28),
                SizedBox(width: SizeConfig.blockWidth * 2),
                Text(
                  'Your Favorites',
                  style: TextStyle(
                    fontSize: SizeConfig.blockWidth * 7,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkTextPrimary,
                  ),
                ),
              ],
            ),
          ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.blockWidth * 2,
                vertical: SizeConfig.blockHeight * 1,
              ),
              child: SearchTextField(
                hintText: 'Search your vault...',
                onChanged: (value) {
                  searchQuery = value;
                  _updateFilteredQuotes();
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.blockWidth * 4,
                vertical: SizeConfig.blockHeight * 1,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? AppColors.darkSurfaceLight
                      : AppColors.lightSurfaceLight,
                  borderRadius:
                      BorderRadius.circular(SizeConfig.blockWidth * 3),
                ),
                padding: EdgeInsets.all(SizeConfig.blockWidth * 0.5),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isGridView = true;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: isGridView
                                ? (Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? AppColors.lightBg
                                    : AppColors.darkBg.withOpacity(0.4))
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(
                              SizeConfig.blockWidth * 2,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: SizeConfig.blockHeight * 1,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.grid_view,
                                color: isGridView
                                    ? AppColors.primaryColor
                                    : (Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? AppColors.darkTextSecondary
                                        : AppColors.lightTextSecondary),
                                size: SizeConfig.blockWidth * 5,
                              ),
                              SizedBox(width: SizeConfig.blockWidth * 1.5),
                              Text(
                                'Grid',
                                style: TextStyle(
                                  fontSize: SizeConfig.blockWidth * 3.5,
                                  fontWeight: isGridView
                                      ? FontWeight.bold
                                      : FontWeight.w500,
                                  color: isGridView
                                      ? AppColors.primaryColor
                                      : (Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? AppColors.darkTextSecondary
                                          : AppColors.lightTextSecondary),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isGridView = false;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: !isGridView
                                ? (Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? AppColors.lightBg
                                    : AppColors.darkBg.withOpacity(0.5))
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(
                              SizeConfig.blockWidth * 2,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: SizeConfig.blockHeight * 1,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.list,
                                color: !isGridView
                                    ? AppColors.primaryColor
                                    : (Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? AppColors.darkTextSecondary
                                        : AppColors.lightTextSecondary),
                                size: SizeConfig.blockWidth * 5,
                              ),
                              SizedBox(width: SizeConfig.blockWidth * 1.5),
                              Text(
                                'List',
                                style: TextStyle(
                                  fontSize: SizeConfig.blockWidth * 3.5,
                                  fontWeight: !isGridView
                                      ? FontWeight.bold
                                      : FontWeight.w500,
                                  color: !isGridView
                                      ? AppColors.primaryColor
                                      : (Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? AppColors.darkTextSecondary
                                          : AppColors.lightTextSecondary),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(SizeConfig.blockWidth * 4),
              child: SizedBox(
                  child: filteredQuotes.isEmpty
                      ? EmptyState(
                          hasSearchQuery: searchQuery.isNotEmpty,
                          onExploreTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Navigate to explore')),
                            );
                          },
                        )
                      : isGridView
                          ? GridView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsetsDirectional.symmetric(
                                vertical: SizeConfig.blockHeight * 1,
                              ),
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: SizeConfig.blockWidth * 3,
                                mainAxisSpacing: SizeConfig.blockHeight * 2,
                                childAspectRatio: 1,
                              ),
                              itemCount: filteredQuotes.length,
                              itemBuilder: (context, index) {
                                return GridQuoteCard(
                                    quote: filteredQuotes[index]);
                              },
                            )
                          : ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: EdgeInsetsDirectional.symmetric(
                                vertical: SizeConfig.blockHeight * 1,
                              ),
                              itemCount: filteredQuotes.length,
                              separatorBuilder: (context, index) => SizedBox(
                                  height: SizeConfig.blockHeight *
                                      2), // 👈 spacing here
                              itemBuilder: (context, index) {
                                return QuoteCard(
                                  quote: filteredQuotes[index].text,
                                  author: filteredQuotes[index].author,
                                  genre: filteredQuotes[index].genre,
                                  isLiked: filteredQuotes[index].isFavorite,
                                  onLike: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Quote ${filteredQuotes[index].isFavorite ? "unliked" : "liked"}',
                                        ),
                                      ),
                                    );
                                  },
                                  onShare: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Shared: ${filteredQuotes[index].text}',
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            )),
            ),
            SizedBox(height: SizeConfig.blockHeight * 2),
          ],
        ),
      ),
    );
  }
}
