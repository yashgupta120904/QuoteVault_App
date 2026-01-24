import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quotevault/routes/app_routes.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/size_config.dart';
import '../../../../core/utils/custom_snackbar.dart';
import '../../../explore/presentation/widgets/custom_search_textfield.dart';
import '../../../quotes/presentation/widgets/quote_card.dart';
import '../provider/favorites_provider.dart';
import '../widgets/custom_favorites_grid.dart';
import '../widgets/empty_state.dart';

class VaultScreen extends StatefulWidget {
  const VaultScreen({super.key});

  @override
  State<VaultScreen> createState() => _VaultScreenState();
}

class _VaultScreenState extends State<VaultScreen> {
  bool isGridView = true;
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FavoritesProvider>().loadFavorites();
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Consumer<FavoritesProvider>(
        builder: (context, provider, _) {
          final filteredQuotes = provider.search(searchQuery);

          return RefreshIndicator(
            onRefresh: provider.loadFavorites,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  /// HEADER
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      SizeConfig.blockWidth * 4,
                      SizeConfig.blockHeight * 5,
                      SizeConfig.blockWidth * 4,
                      0,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.favorite,
                          color: isDark
                              ? AppColors.darkTextPrimary
                              : AppColors.darkBg,
                          size: 28,
                        ),
                        SizedBox(width: SizeConfig.blockWidth * 2),
                        Text(
                          'Your Favorites',
                          style: TextStyle(
                            fontSize: SizeConfig.blockWidth * 5,
                            fontWeight: FontWeight.bold,
                            color: isDark
                                ? AppColors.darkTextPrimary
                                : AppColors.darkBg,
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// SEARCH
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.blockWidth * 2,
                      vertical: SizeConfig.blockHeight * 1,
                    ),
                    child: SearchTextField(
                      hintText: 'Search your vault...',
                      onChanged: (value) {
                        setState(() => searchQuery = value);
                      },
                    ),
                  ),

                  /// TOGGLE
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.blockWidth * 4,
                      vertical: SizeConfig.blockHeight * 1,
                    ),
                    child: _buildToggle(context),
                  ),

                  /// CONTENT
                  Padding(
                    padding: EdgeInsets.all(SizeConfig.blockWidth * 4),
                    child: provider.isLoading
                        ? _buildLoading()
                        : filteredQuotes.isEmpty
                            ? EmptyState(
                                hasSearchQuery: searchQuery.isNotEmpty,
                                onExploreTap: () {
                                  Navigator.pushNamed(
                                      context, AppRoutes.explore);
                                },
                              )
                            : isGridView
                                ? _buildGrid(filteredQuotes, provider)
                                : _buildList(filteredQuotes, provider),
                  ),

                  SizedBox(height: SizeConfig.blockHeight * 2),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  /// ------------------------------------------------
  /// GRID VIEW
  /// ------------------------------------------------
  Widget _buildGrid(List quotes, FavoritesProvider provider) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: SizeConfig.blockWidth * 3,
        mainAxisSpacing: SizeConfig.blockHeight * 2,
        childAspectRatio: 1,
      ),
      itemCount: quotes.length,
      itemBuilder: (_, index) {
        final quote = quotes[index];
        return GridQuoteCard(
          quote: quote,
          onToggleFavorite: () async {
            final success = await provider.removeFromFavorites(quote);

            showCustomSnackbar(
              type: success ? SnackbarType.info : SnackbarType.error,
              title: success ? 'Removed' : 'Error',
              message:
                  success ? 'Removed from favorites' : 'Failed to remove quote',
            );
          },
        );
      },
    );
  }

  /// ------------------------------------------------
  /// LIST VIEW
  /// ------------------------------------------------
  Widget _buildList(List quotes, FavoritesProvider provider) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: quotes.length,
      separatorBuilder: (_, __) => SizedBox(height: SizeConfig.blockHeight * 2),
      itemBuilder: (_, index) {
        final quote = quotes[index];
        return QuoteCard(
          quote: quote.text,
          author: quote.author,
          genre: quote.category,
          isLiked: true,
          onLike: () async {
            final success = await provider.removeFromFavorites(quote);

            showCustomSnackbar(
              type: success ? SnackbarType.success : SnackbarType.error,
              title: success ? 'Removed' : 'Error',
              message:
                  success ? 'Removed from favorites' : 'Failed to remove quote',
            );
          },
          onShare: () {},
        );
      },
    );
  }

  /// ------------------------------------------------
  Widget _buildLoading() {
    return SizedBox(
      height: SizeConfig.blockHeight * 40,
      child: const Center(
        child: CircularProgressIndicator(
          color: AppColors.primaryColor,
        ),
      ),
    );
  }

  /// ------------------------------------------------
  Widget _buildToggle(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? AppColors.darkSurfaceLight
            : AppColors.lightSurfaceLight,
        borderRadius: BorderRadius.circular(SizeConfig.blockWidth * 3),
      ),
      padding: EdgeInsets.all(SizeConfig.blockWidth * 0.5),
      child: Row(
        children: [
          Expanded(
            child: _toggleBtn(
              icon: Icons.grid_view,
              label: 'Grid',
              selected: isGridView,
              onTap: () => setState(() => isGridView = true),
            ),
          ),
          Expanded(
            child: _toggleBtn(
              icon: Icons.list,
              label: 'List',
              selected: !isGridView,
              onTap: () => setState(() => isGridView = false),
            ),
          ),
        ],
      ),
    );
  }

  Widget _toggleBtn({
    required IconData icon,
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color:
              selected ? AppColors.darkBg.withOpacity(0.4) : Colors.transparent,
          borderRadius: BorderRadius.circular(SizeConfig.blockWidth * 2),
        ),
        padding: EdgeInsets.symmetric(vertical: SizeConfig.blockHeight),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon,
                color: selected
                    ? AppColors.primaryColor
                    : AppColors.lightTextSecondary),
            SizedBox(width: SizeConfig.blockWidth * 1.5),
            Text(
              label,
              style: TextStyle(
                fontWeight: selected ? FontWeight.bold : FontWeight.w500,
                color: selected
                    ? AppColors.primaryColor
                    : AppColors.lightTextSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
