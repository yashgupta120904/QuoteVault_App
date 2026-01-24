import 'package:supabase_flutter/supabase_flutter.dart';

class FavoritesRemoteDataSource {
  final SupabaseClient _client;

  FavoritesRemoteDataSource(this._client);

  Future<List<Map<String, dynamic>>> fetchFavoriteQuotes(
    String userId,
  ) async {
    return await _client
        .from('user_favorites')
        .select('quotes(*)')
        .eq('user_id', userId);
  }

  Future<void> removeFavorite({
    required String userId,
    required String quoteId,
  }) async {
    await _client.from('user_favorites').delete().match({
      'user_id': userId,
      'quote_id': quoteId,
    });
  }
}
