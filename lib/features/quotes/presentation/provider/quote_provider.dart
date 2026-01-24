
import 'package:flutter/material.dart';

import '../../../../core/services/widget_sync.dart';
import '../../data/models/quote_model.dart';
import '../../data/repository/quote_remote_datasource.dart.dart';
import '../../domain/repository/quote_repo.dart';

class QuoteProvider extends ChangeNotifier {
  final QuoteRepository _repository =
      QuoteRepository(QuoteRemoteDataSource());

  final List<Quote> _quotes = [];
  List<Quote> get quotes => _quotes;

  Quote? quoteOfDay;
  Quote? activeQuote;

  late String _userId;

  int _page = 0;
  bool isLoading = false;
  bool hasMore = true;
  bool _isFirstLoad = true;

  static const int _pageSize = 20;

  /// ================= INITIAL LOAD =================
  Future<void> loadInitial(String userId) async {
    if (!_isFirstLoad) return;

    _userId = userId;
    _isFirstLoad = false;

    _page = 0;
    hasMore = true;
    _quotes.clear();

    isLoading = true;
    notifyListeners();

    await Future.wait([
      _loadDailyQuote(),
      _loadMoreInternal(),
    ]);

    isLoading = false;
    notifyListeners();
  }

  /// ================= DAILY QUOTE =================
  Future<void> _loadDailyQuote() async {
    try {
      quoteOfDay = await _repository.getQuoteOfTheDay(
        userId: _userId,
      );

      await WidgetSyncService.syncQuoteOfDay(quoteOfDay!);
      notifyListeners();
    } catch (_) {}
  }

  /// ================= LOAD MORE =================
  Future<void> loadMore() async {
    if (isLoading || !hasMore) return;
    await _loadMoreInternal();
  }

  Future<void> _loadMoreInternal() async {
    isLoading = true;
    notifyListeners();

    try {
      final newQuotes = await _repository.getQuotes(
        userId: _userId,
        page: _page,
      );

      if (newQuotes.length < _pageSize) {
        hasMore = false;
      }

      _quotes.addAll(newQuotes);
      _page++;
    } catch (_) {}

    isLoading = false;
    notifyListeners();
  }

  /// ================= REFRESH (SHUFFLE 🔀) =================
  Future<void> refresh() async {
    _page = 0;
    hasMore = true;
    _quotes.clear();

    isLoading = true;
    notifyListeners();

    try {
      final newQuotes = await _repository.getQuotes(
        userId: _userId,
        page: 0,
      );

      // 🔥 Shuffle ONLY other quotes
      newQuotes.shuffle();

      _quotes.addAll(newQuotes);
      _page = 1;
    } catch (_) {}

    // 🔥 Re-sync daily quote (keeps favorite state correct)
    await _loadDailyQuote();

    isLoading = false;
    notifyListeners();
  }

  /// ================= FAVORITES =================
  Future<void> toggleFavorite({
    required Quote quote,
  }) async {
    await _repository.toggleFavorite(
      userId: _userId,
      quote: quote,
    );

    // Update daily quote state
    if (quoteOfDay?.id == quote.id) {
      quoteOfDay =
          quoteOfDay!.copyWith(isFavorite: !quoteOfDay!.isFavorite);
    }

    // Update list
    final index = _quotes.indexWhere((q) => q.id == quote.id);
    if (index != -1) {
      _quotes[index] =
          _quotes[index].copyWith(isFavorite: !_quotes[index].isFavorite);
    }

    notifyListeners();
  }

  void setActiveQuote(Quote quote) {
    activeQuote = quote;
    notifyListeners();
  }

  List<Quote> get favorites =>
      _quotes.where((q) => q.isFavorite).toList();
}
