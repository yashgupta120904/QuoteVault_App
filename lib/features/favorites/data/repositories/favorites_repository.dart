import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../quotes/data/models/quote_model.dart';
import '../datasources/favorites_remote_datasource.dart';

class FavoritesRepository {
  final FavoritesRemoteDataSource _remote;

  FavoritesRepository()
      : _remote = FavoritesRemoteDataSource(
          Supabase.instance.client,
        );

  Future<List<Quote>> fetchFavorites(String userId) async {
    final res = await _remote.fetchFavoriteQuotes(userId);

    return res.map<Quote>((e) {
      final q = e['quotes'];
      return Quote.fromMap(
        q,
        isFavorite: true,
      );
    }).toList();
  }

  Future<void> removeFavorite({
    required String userId,
    required String quoteId,
  }) async {
    await _remote.removeFavorite(
      userId: userId,
      quoteId: quoteId,
    );
  }
}
