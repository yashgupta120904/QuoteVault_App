
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/custom_snackbar.dart';
import '../../../../core/utils/size_config.dart';


import '../../../../routes/app_routes.dart';
import '../../../quotes/data/models/quote_model.dart';
import '../../../quotes/presentation/provider/quote_provider.dart';
import '../widgets/category_pills.dart';
import '../../../quotes/presentation/widgets/quote_card.dart';
import '../provider/explore_provider.dart';
import '../widgets/custom_author_card.dart';
import '../widgets/custom_search_textfield.dart';



class ExploreScreen extends StatefulWidget {
  final bool autoFocusSearch;

  const ExploreScreen({
    super.key,
    this.autoFocusSearch = false,
  });

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  late FocusNode _searchFocusNode;
  late ScrollController _scrollController;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _searchFocusNode = FocusNode();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ExploreProvider>().loadInitial();

      if (widget.autoFocusSearch) {
        _searchFocusNode.requestFocus();
      }
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<ExploreProvider>().loadMoreQuotes();
    }
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _handleToggleFavorite(
    ExploreProvider provider,
    Quote q,
  ) async {
    try {
      final wasFavorite = q.isFavorite;

      await provider.toggleFavorite(q);

      if (!wasFavorite) {
        showCustomSnackbar(
          type: SnackbarType.success,
          title: 'Added to Favorites',
          message: 'Quote saved to your collection',
        );
      } else {
        showCustomSnackbar(
          type: SnackbarType.info,
          title: 'Removed from Favorites',
          message: 'Quote removed from your collection',
        );
      }
    } catch (_) {
      showCustomSnackbar(
        type: SnackbarType.error,
        title: 'Error',
        message: 'Failed to update favorite',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Consumer<ExploreProvider>(
        builder: (context, provider, _) {
          return RefreshIndicator(
            onRefresh: provider.refresh,
            color: AppColors.primaryColor,
            child: SingleChildScrollView(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// 🔍 Header
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      SizeConfig.blockWidth * 4,
                      SizeConfig.blockHeight * 7,
                      SizeConfig.blockWidth * 4,
                      SizeConfig.blockHeight * 0.8,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.explore,
                          color: isDark
                              ? AppColors.lightSurfaceDark
                              : AppColors.darkSurfaceLight,
                          size: 28,
                        ),
                        SizedBox(width: SizeConfig.blockWidth * 2),
                        Text(
                          'Explore',
                          style: TextStyle(
                            fontSize: SizeConfig.blockWidth * 7,
                            fontWeight: FontWeight.bold,
                            color: isDark
                                ? AppColors.lightSurfaceDark
                                : AppColors.darkSurfaceLight,
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// 🔎 Search
                  SearchTextField(
                    focusNode: _searchFocusNode,
                    onChanged: (query) {
                      setState(() => _searchQuery = query);
                      provider.search(query);
                    },
                  ),

                  /// 🏷 Categories
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.blockWidth * 4,
                      vertical: SizeConfig.blockHeight * 2,
                    ),
                    child: CategoryPills(
                      categories: provider.categories,
                      selectedIndex: provider.selectedCategoryIndex,
                      onTap: provider.changeCategory,
                    ),
                  ),

                  /// 🔥 Trending Authors
                  if (_searchQuery.isEmpty &&
                      provider.trendingAuthors.isNotEmpty) ...[
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.blockWidth * 4,
                      ),
                      child: Text(
                        'Trending Authors',
                        style: TextStyle(
                          fontSize: SizeConfig.blockWidth * 4,
                          fontWeight: FontWeight.bold,
                          color: isDark
                              ? Colors.white
                              : AppColors.lightTextPrimary,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(SizeConfig.blockWidth * 4),
                      child: Row(
                        children: [
                          Expanded(
                            child: AuthorCard(
                              name: provider.trendingAuthors[0].name,
                              category:
                                  provider.trendingAuthors[0].category,
                              wikiKey:
                                  provider.trendingAuthors[0].wikiKey,
                            ),
                          ),
                          if (provider.trendingAuthors.length > 1)
                            SizedBox(
                                width: SizeConfig.blockWidth * 4),
                          if (provider.trendingAuthors.length > 1)
                            Expanded(
                              child: AuthorCard(
                                name:
                                    provider.trendingAuthors[1].name,
                                category: provider
                                    .trendingAuthors[1].category,
                                wikiKey: provider
                                    .trendingAuthors[1].wikiKey,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],

                  /// 🧠 Quotes
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.blockWidth * 4,
                    ),
                    child: Text(
                      'Quotes',
                      style: TextStyle(
                        fontSize: SizeConfig.blockWidth * 4,
                        fontWeight: FontWeight.bold,
                        color: isDark
                            ? Colors.white
                            : AppColors.lightTextPrimary,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  /// Initial loader only
                  if (provider.isInitialLoading &&
                      provider.quotes.isEmpty)
                    const Padding(
                      padding: EdgeInsets.all(32),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  else
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.blockWidth * 4,
                      ),
                      child: Column(
                        children: provider.quotes.map((q) {
                          return Padding(
                            padding:
                                const EdgeInsets.only(bottom: 12),
                            child: QuoteCard(
                              quote: q.text,
                              author: q.author,
                              genre: q.category,
                              isLiked: q.isFavorite,
                              onLike: () =>
                                  _handleToggleFavorite(provider, q),
                              onShare:  (){
                      final quoteProvider =
                          context.read<QuoteProvider>();

                      /// Set active quote (NO PARAMS PASSED)
                      quoteProvider.setActiveQuote(
                        Quote(
                          id: '', // safe placeholder if id required
                          text: q.text,
                          author: q.author,
                          category: q.category,
                          isFavorite: q.isFavorite, wikiKey: '',
                        ),
                      );

                      Navigator.pushNamed(
                        context,
                        AppRoutes.share,
                      );
                    },
                            ),
                          );
                        }).toList(),
                      ),
                    ),

                  /// Pagination loader
                  if (provider.isLoadingMore)
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: SizeConfig.blockHeight * 2,
                      ),
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),

                  SizedBox(height: SizeConfig.blockHeight * 4),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
