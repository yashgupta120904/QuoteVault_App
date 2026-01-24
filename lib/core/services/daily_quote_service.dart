import 'package:supabase_flutter/supabase_flutter.dart';
import '../../features/quotes/data/models/quote_model.dart';


class DailyQuoteService {
  final SupabaseClient _client = Supabase.instance.client;

  Future<Quote?> fetchDailyQuote() async {
    final response = await _client
        .from('quotes')
        .select()
        .eq('is_daily', true)
        .single();

    return Quote.fromMap(response);
  }
}
