
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../quotes/data/models/quote_model.dart';
import '../../data/models/author_model.dart';
import '../../data/repository/explore_repository.dart';

class ExploreProvider extends ChangeNotifier {
  final ExploreRepository _repo = ExploreRepository();

  // ───────────────────── DATA ─────────────────────

  List<String> categories = [];
  List<Quote> quotes = [];
  List<Quote> _allQuotes = [];
  List<Author> trendingAuthors = [];

  // Cache authors per category (IMPORTANT)
  final Map<String, List<Author>> _authorsCache = {};

  int selectedCategoryIndex = 0;
  int _quotePage = 0;
  bool _hasMoreQuotes = true;
  String _searchQuery = '';
  String? error;

  // ───────────────────── LOADING STATES ─────────────────────
  // These are SEPARATE on purpose

  bool isInitialLoading = false;   // app start only
  bool isRefreshing = false;      // pull to refresh only
  bool isLoadingMore = false;     // pagination only

  // ───────────────────── GETTERS ─────────────────────

  String get selectedCategory =>
      categories.isEmpty ? 'All Topics' : categories[selectedCategoryIndex];

  String get _userId =>
      Supabase.instance.client.auth.currentUser!.id;

  // ───────────────────── INITIAL LOAD ─────────────────────

  Future<void> loadInitial() async {
    isInitialLoading = true;
    notifyListeners();

    try {
      categories = await _repo.fetchCategories();
      _quotePage = 0;
      _hasMoreQuotes = true;

      await _loadCategoryData();
    } catch (e) {
      error = e.toString();
    }

    isInitialLoading = false;
    notifyListeners();
  }

  // ───────────────────── PULL TO REFRESH ─────────────────────

  Future<void> refresh() async {
    if (isRefreshing) return;

    isRefreshing = true;
    notifyListeners();

    try {
      _quotePage = 0;
      _hasMoreQuotes = true;
      await _loadCategoryData();
    } catch (e) {
      error = e.toString();
    }

    isRefreshing = false;
    notifyListeners();
  }

  // ───────────────────── CATEGORY CHANGE (SILENT) ─────────────────────
  // ❗ NO loading flags here ❗

  Future<void> changeCategory(int index) async {
    if (index == selectedCategoryIndex) return;

    selectedCategoryIndex = index;
    _searchQuery = '';
    _quotePage = 0;
    _hasMoreQuotes = true;

    notifyListeners(); // updates pills immediately

    try {
      await _loadCategoryData();
    } catch (e) {
      error = e.toString();
    }

    notifyListeners(); // replace data smoothly
  }

  // ───────────────────── LOAD CATEGORY DATA ─────────────────────

  Future<void> _loadCategoryData() async {
    // -------- QUOTES --------
    final newQuotes = await _repo.fetchQuotesByCategory(
      userId: _userId,
      category: selectedCategory,
      page: 0,
    );

    newQuotes.shuffle();
    _allQuotes = List.from(newQuotes);
    quotes = List.from(newQuotes);
    _quotePage = 1;

    // -------- AUTHORS (CACHED) --------
    if (_authorsCache.containsKey(selectedCategory)) {
      trendingAuthors = _authorsCache[selectedCategory]!;
    } else {
      final authors =
          await _repo.fetchTrendingAuthors(selectedCategory);
      _authorsCache[selectedCategory] = authors;
      trendingAuthors = authors;
    }
  }

  // ───────────────────── PAGINATION ─────────────────────

  Future<void> loadMoreQuotes() async {
    if (isLoadingMore || !_hasMoreQuotes || _searchQuery.isNotEmpty) return;

    isLoadingMore = true;
    notifyListeners();

    try {
      final newQuotes = await _repo.fetchQuotesByCategory(
        userId: _userId,
        category: selectedCategory,
        page: _quotePage,
      );

      if (newQuotes.isEmpty) {
        _hasMoreQuotes = false;
      } else {
        newQuotes.shuffle();
        _allQuotes.addAll(newQuotes);
        quotes = List.from(_allQuotes);
        _quotePage++;
      }
    } catch (e) {
      error = e.toString();
    }

    isLoadingMore = false;
    notifyListeners();
  }

  // ───────────────────── SEARCH ─────────────────────

  void search(String query) {
    _searchQuery = query.toLowerCase();

    if (_searchQuery.isEmpty) {
      quotes = List.from(_allQuotes);
    } else {
      quotes = _allQuotes.where((q) {
        return q.text.toLowerCase().contains(_searchQuery) ||
            q.author.toLowerCase().contains(_searchQuery) ||
            q.category.toLowerCase().contains(_searchQuery);
      }).toList();
    }

    notifyListeners();
  }

  // ───────────────────── TOGGLE FAVORITE ─────────────────────

  Future<void> toggleFavorite(Quote quote) async {
    try {
      await _repo.toggleFavorite(
        userId: _userId,
        quote: quote,
      );

      final allIndex = _allQuotes.indexWhere((q) => q.id == quote.id);
      if (allIndex != -1) {
        _allQuotes[allIndex] =
            _allQuotes[allIndex].copyWith(
              isFavorite: !_allQuotes[allIndex].isFavorite,
            );
      }

      final index = quotes.indexWhere((q) => q.id == quote.id);
      if (index != -1) {
        quotes[index] =
            quotes[index].copyWith(
              isFavorite: !quotes[index].isFavorite,
            );
      }

      notifyListeners();
    } catch (e) {
      error = e.toString();
      notifyListeners();
    }
  }
}
