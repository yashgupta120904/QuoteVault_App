
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../quotes/data/models/quote_model.dart';
import '../../data/repositories/favorites_repository.dart';

class FavoritesProvider extends ChangeNotifier {
  final FavoritesRepository _repo = FavoritesRepository();

  List<Quote> favorites = [];
  bool isLoading = false;

  String? get _userId =>
      Supabase.instance.client.auth.currentUser?.id;

  /// -------------------------------
  /// LOAD FAVORITES
  /// -------------------------------
  Future<void> loadFavorites() async {
    if (_userId == null) return;

    isLoading = true;
    notifyListeners();

    try {
      favorites = await _repo.fetchFavorites(_userId!);
    } catch (e) {
      debugPrint('Load favorites error: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// -------------------------------
  /// REMOVE FROM FAVORITES
  /// -------------------------------
  Future<bool> removeFromFavorites(Quote quote) async {
    if (_userId == null) return false;

    try {
      await _repo.removeFavorite(
        userId: _userId!,
        quoteId: quote.id,
      );

      favorites.removeWhere((q) => q.id == quote.id);
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint('Remove favorite error: $e');
      return false;
    }
  }

  /// -------------------------------
  /// SEARCH
  /// -------------------------------
  List<Quote> search(String query) {
    if (query.isEmpty) return favorites;

    final q = query.toLowerCase();
    return favorites.where((quote) {
      return quote.text.toLowerCase().contains(q) ||
          quote.author.toLowerCase().contains(q) ||
          quote.category.toLowerCase().contains(q);
    }).toList();
  }
}
