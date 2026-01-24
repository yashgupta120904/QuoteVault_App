
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/quote_model.dart';

class QuoteRemoteDataSource {
  final SupabaseClient _client = Supabase.instance.client;
  static const int pageSize = 20;

  /// ================= ALL QUOTES =================
  Future<List<Quote>> fetchQuotes({
    required String userId,
    required int page,
  }) async {
    final from = page * pageSize;
    final to = from + pageSize - 1;

    final quotesRes = await _client
        .from('quotes')
        .select()
        .order('created_at', ascending: false)
        .range(from, to);

    final favRes = await _client
        .from('user_favorites')
        .select('quote_id')
        .eq('user_id', userId);

    final favIds = favRes.map((e) => e['quote_id']).toSet();

    return quotesRes.map<Quote>((q) {
      return Quote.fromMap(
        q,
        isFavorite: favIds.contains(q['id']),
      );
    }).toList();
  }

  /// ================= DAILY QUOTE (USER AWARE) =================
  Future<Quote> fetchQuoteOfTheDay({
    required String userId,
  }) async {
    final quoteRes = await _client
        .from('quotes')
        .select()
        .eq('is_daily', true)
        .single();

    final favRes = await _client
        .from('user_favorites')
        .select('quote_id')
        .eq('user_id', userId)
        .eq('quote_id', quoteRes['id'])
        .maybeSingle();

    return Quote.fromMap(
      quoteRes,
      isFavorite: favRes != null,
    );
  }

  /// ================= FAVORITES =================
  Future<void> addFavorite({
    required String userId,
    required String quoteId,
  }) async {
    await _client.from('user_favorites').upsert(
      {
        'user_id': userId,
        'quote_id': quoteId,
      },
      onConflict: 'user_id,quote_id',
    );
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
