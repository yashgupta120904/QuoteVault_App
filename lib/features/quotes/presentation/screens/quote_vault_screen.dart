import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:home_widget/home_widget.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/custom_snackbar.dart';
import '../../../../core/utils/size_config.dart';
import '../../../../routes/app_routes.dart';
import '../../data/models/quote_model.dart';
import '../provider/quote_provider.dart';
import '../widgets/custom_search.dart';
import '../widgets/quote_card.dart';

class QuoteVaultScreen extends StatefulWidget {
  const QuoteVaultScreen({super.key});

  @override
  State<QuoteVaultScreen> createState() => _QuoteVaultScreenState();
}

class _QuoteVaultScreenState extends State<QuoteVaultScreen> {
  final ScrollController _scrollController = ScrollController();
  late final String userId;

  @override
  void initState() {
    super.initState();

    userId = Supabase.instance.client.auth.currentUser!.id;

    /// ⛳ Load data AFTER widget is mounted
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<QuoteProvider>().loadInitial(userId);
    });

    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final provider = context.read<QuoteProvider>();

    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      provider.loadMore();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  /* ================= ADD HOME WIDGET (AUTO + MANUAL FALLBACK) ================= */

  Future<void> _requestAddHomeWidget() async {
    try {
      final bool? supported =
          await HomeWidget.isRequestPinWidgetSupported();

      debugPrint('📦 Widget pin supported: $supported');

      if (supported == true) {
        await HomeWidget.requestPinWidget(
          name: 'HomeWidgetExampleProvider',
          androidName: 'HomeWidgetExampleProvider',
        );

     
      } else {
        _showAddWidgetSheet();
      }
    } catch (e, st) {
      debugPrint('❌ Widget error: $e');
      debugPrint('$st');
      _showAddWidgetSheet();
    }
  }

  void _showAddWidgetSheet() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.3),
      isScrollControlled: true,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1A1A1A) : Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(28),
            topRight: Radius.circular(28),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            SizeConfig.blockWidth * 4,
            SizeConfig.blockHeight * 1.5,
            SizeConfig.blockWidth * 4,
            SizeConfig.blockHeight * 3,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// Handle bar
              Container(
                width: SizeConfig.blockWidth * 12,
                height: 4,
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.white.withOpacity(0.15)
                      : Colors.black.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              SizedBox(height: SizeConfig.blockHeight * 2.5),

              /// Header with icon
              Container(
                width: SizeConfig.blockWidth * 16,
                height: SizeConfig.blockWidth * 16,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primaryColor.withOpacity(0.15),
                      AppColors.accentPurple.withOpacity(0.15),
                    ],
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.widgets_rounded,
                    size: SizeConfig.blockWidth * 8,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
              SizedBox(height: SizeConfig.blockHeight * 2),

              /// Title
              Text(
                'Add Widget to Home Screen',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: SizeConfig.blockWidth * 4.5,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : AppColors.darkSurfaceDark,
                ),
              ),
              SizedBox(height: SizeConfig.blockHeight * 1),

              /// Description
              Text(
                'Get quick access to daily quotes on your home screen',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: SizeConfig.blockWidth * 2.8,
                  color: isDark ? Colors.grey[400] : AppColors.darkTextSecondary,
                  height: 1.5,
                ),
              ),
              SizedBox(height: SizeConfig.blockHeight * 3),

              /// Steps container
              Container(
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.white.withOpacity(0.05)
                      : Colors.black.withOpacity(0.02),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isDark
                        ? Colors.white.withOpacity(0.08)
                        : Colors.black.withOpacity(0.05),
                  ),
                ),
                padding: EdgeInsets.all(SizeConfig.blockWidth * 4),
                child: Column(
                  children: [
                    _buildWidgetStep(
                      isDark,
                      step: '1',
                      title: 'Long press home screen',
                      description: 'Hold your finger on an empty area',
                    ),
                    SizedBox(height: SizeConfig.blockHeight * 2),
                    _buildDivider(isDark),
                    SizedBox(height: SizeConfig.blockHeight * 2),
                    _buildWidgetStep(
                      isDark,
                      step: '2',
                      title: 'Tap Widgets',
                      description: 'Select the Widgets option from menu',
                    ),
                    SizedBox(height: SizeConfig.blockHeight * 2),
                    _buildDivider(isDark),
                    SizedBox(height: SizeConfig.blockHeight * 2),
                    _buildWidgetStep(
                      isDark,
                      step: '3',
                      title: 'Find QuoteVault',
                      description: 'Search or scroll to QuoteVault widget',
                    ),
                    SizedBox(height: SizeConfig.blockHeight * 2),
                    _buildDivider(isDark),
                    SizedBox(height: SizeConfig.blockHeight * 2),
                    _buildWidgetStep(
                      isDark,
                      step: '4',
                      title: 'Drag & Done',
                      description: 'Drag widget to desired position',
                    ),
                  ],
                ),
              ),
              SizedBox(height: SizeConfig.blockHeight * 3),

              /// Action buttons
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          vertical: SizeConfig.blockHeight * 1.4,
                        ),
                      ),
                      child: Text(
                        'Maybe Later',
                        style: TextStyle(
                          fontSize: SizeConfig.blockWidth * 3.5,
                          fontWeight: FontWeight.w600,
                          color: isDark
                              ? Colors.grey[400]
                              : Colors.grey[600],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: SizeConfig.blockWidth * 3),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primaryColor,
                            AppColors.accentPurple,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(
                          SizeConfig.blockWidth * 4,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primaryColor.withOpacity(0.3),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            showCustomSnackbar(
                              type: SnackbarType.success,
                              title: 'Got it!',
                              message: 'Follow the steps to add widget',
                            );
                          },
                          borderRadius: BorderRadius.circular(
                            SizeConfig.blockWidth * 4,
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: SizeConfig.blockHeight * 1.4,
                            ),
                            child: Text(
                              'Got it',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: SizeConfig.blockWidth * 3.5,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWidgetStep(
    bool isDark, {
    required String step,
    required String title,
    required String description,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: SizeConfig.blockWidth * 9,
          height: SizeConfig.blockWidth * 9,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                AppColors.primaryColor.withOpacity(0.9),
                AppColors.accentPurple.withOpacity(0.8),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryColor.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: Text(
              step,
              style: TextStyle(
                fontSize: SizeConfig.blockWidth * 4.2,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(width: SizeConfig.blockWidth * 3.5),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: SizeConfig.blockWidth * 3.5,
                  fontWeight: FontWeight.w700,
                  color: isDark ? Colors.white : AppColors.darkSurfaceDark,
                ),
              ),
              SizedBox(height: SizeConfig.blockHeight * 0.5),
              Text(
                description,
                style: TextStyle(
                  fontSize: SizeConfig.blockWidth * 2.6,
                  color: isDark
                      ? Colors.grey[400]
                      : AppColors.darkTextSecondary,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDivider(bool isDark) {
    return Container(
      height: 1,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.transparent,
            isDark
                ? Colors.white.withOpacity(0.1)
                : Colors.black.withOpacity(0.05),
            Colors.transparent,
          ],
        ),
      ),
    );
  }

  /* ================= FAVORITE HANDLER ================= */

  Future<void> _handleToggleFavorite(
    QuoteProvider provider,
    Quote q,
    String userId,
  ) async {
    try {
      final wasFavorite = q.isFavorite;

      await provider.toggleFavorite(
      
        quote: q,
      );

      // Check opposite of what it was before
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
    } catch (e) {
      showCustomSnackbar(
        type: SnackbarType.error,
        title: 'Error',
        message: 'Failed to update favorite. Please try again.',
      );
      debugPrint('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    final provider = context.watch<QuoteProvider>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          color: AppColors.primaryColor,
          onRefresh: () => provider.refresh(),
          child: SingleChildScrollView(
            controller: _scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.blockWidth * 4,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(isDark),

                  /// 🔮 Quote of the Day
                  if (provider.quoteOfDay != null)
                    _buildFeaturedQuote(provider, isDark),

                  /// ➕ ADD WIDGET CTA
                  SizedBox(height: SizeConfig.blockHeight * 2),
                  GestureDetector(
                    onTap: _requestAddHomeWidget,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: SizeConfig.blockHeight * 1.4,
                        horizontal: SizeConfig.blockWidth * 4,
                      ),
                      decoration: BoxDecoration(
                        color: isDark
                            ? Colors.white.withOpacity(0.08)
                            : Colors.black.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(
                          SizeConfig.blockWidth * 3,
                        ),
                        border: Border.all(
                          color: isDark
                              ? Colors.white.withOpacity(0.15)
                              : Colors.black.withOpacity(0.1),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.widgets,
                                  color: isDark
                                      ? Colors.white
                                      : Colors.black),
                              SizedBox(
                                  width:
                                      SizeConfig.blockWidth * 3),
                              Text(
                                'Add Quote to Home Screen',
                                style: TextStyle(
                                  fontSize:
                                      SizeConfig.blockWidth * 3.2,
                                  fontWeight: FontWeight.w600,
                                  color: isDark
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ],
                          ),
                          const Icon(Icons.arrow_forward_ios,
                              size: 16),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: SizeConfig.blockHeight * 2),

                  _buildRecommendedSection(isDark),

                  SizedBox(height: SizeConfig.blockHeight * 1.5),

                  /// 📜 Quotes List
                  if (provider.quotes.isEmpty && provider.isLoading)
                    const Center(child: CircularProgressIndicator())
                  else
                    ...provider.quotes.map(
                      (q) => Padding(
                        padding: EdgeInsets.only(
                          bottom: SizeConfig.blockHeight * 1.5,
                        ),
                        child: QuoteCard(
                          quote: q.text,
                          author: q.author,
                          genre: q.category,
                          isLiked: q.isFavorite,
                          onLike: () {
                            _handleToggleFavorite(provider, q, userId);
                          },
                          onShare: () {
                            final quoteProvider =
                                context.read<QuoteProvider>();

                            /// Set active quote
                            quoteProvider.setActiveQuote(
                              Quote(
                                id: '', // safe placeholder if id required
                                text: q.text,
                                author: q.author,
                                category: q.category,
                                isFavorite: q.isFavorite,
                                wikiKey: '',
                              ),
                            );

                            Navigator.pushNamed(
                              context,
                              AppRoutes.share,
                            );
                          },
                        ),
                      ),
                    ),

                  /// ⏳ Pagination Loader
                  if (provider.isLoading && provider.quotes.isNotEmpty)
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: SizeConfig.blockHeight * 2,
                      ),
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),

                  SizedBox(height: SizeConfig.blockHeight * 3),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ================= HEADER =================

  Widget _buildHeader(bool isDark) {
    final formattedDate =
        DateFormat('EEEE, MMMM d').format(DateTime.now()).toUpperCase();

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
                  color: isDark
                      ? Colors.white
                      : AppColors.darkSurfaceDark,
                ),
              ),
              Text(
                formattedDate,
                style: TextStyle(
                  fontSize: SizeConfig.blockWidth * 2.5,
                  fontWeight: FontWeight.w500,
                  color: isDark
                      ? Colors.grey[400]
                      : AppColors.darkTextSecondary,
                ),
              ),
            ],
          ),
          const SearchCircleButton(),
        ],
      ),
    );
  }

  // ================= FEATURED QUOTE =================

  Widget _buildFeaturedQuote(QuoteProvider provider, bool isDark) {
    final q = provider.quoteOfDay!;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SizeConfig.blockWidth * 4),
        gradient: LinearGradient(
          colors: isDark
              ? [
                  AppColors.accentPurple.withOpacity(0.8),
                  AppColors.primaryColor.withOpacity(0.7),
                ]
              : [
                  const Color.fromARGB(255, 16, 0, 191).withOpacity(0.9),
                  AppColors.primaryColor.withOpacity(0.8),
                ],
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(SizeConfig.blockWidth * 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.blockWidth * 3,
                vertical: SizeConfig.blockHeight * 0.8,
              ),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(isDark ? 0.15 : 0.1),
                borderRadius:
                    BorderRadius.circular(SizeConfig.blockWidth * 1.9),
              ),
              child: Text(
                'QUOTE OF THE DAY',
                style: TextStyle(
                  fontSize: SizeConfig.blockWidth * 2.2,
                  fontWeight: FontWeight.bold,
                  color: isDark
                      ? Colors.white
                      : const Color(0xFFE9D5FF),
                ),
              ),
            ),
            SizedBox(height: SizeConfig.blockHeight * 2),
            Text(
              '"${q.text}"',
              style: TextStyle(
                fontSize: SizeConfig.blockWidth * 5,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
            SizedBox(height: SizeConfig.blockHeight * 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    '— ${q.author}',
                    style: TextStyle(
                      fontSize: SizeConfig.blockWidth * 3.2,
                      color: isDark
                          ? Colors.white
                          : const Color(0xFFE9D5FF),
                    ),
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        q.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        _handleToggleFavorite(provider, q, userId);
                      },
                    ),
                    IconButton(
                      icon: const Icon(
                        CupertinoIcons.share,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        final quoteProvider =
                            context.read<QuoteProvider>();

                        /// Set active quote
                        quoteProvider.setActiveQuote(
                          Quote(
                            id: '', // safe placeholder if id required
                            text: q.text,
                            author: q.author,
                            category: q.category,
                            isFavorite: q.isFavorite,
                            wikiKey: '',
                          ),
                        );

                        Navigator.pushNamed(
                          context,
                          AppRoutes.share,
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ================= SECTION TITLE =================

  Widget _buildRecommendedSection(bool isDark) {
    return Text(
      'Recommended for you',
      style: TextStyle(
        fontSize: SizeConfig.blockWidth * 3.8,
        fontWeight: FontWeight.w600,
        color: isDark
            ? Colors.white
            : AppColors.darkSurfaceDark,
      ),
    );
  }
}
