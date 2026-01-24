
import '../../data/models/quote_model.dart';
import '../../data/repository/quote_remote_datasource.dart.dart';

class QuoteRepository {
  final QuoteRemoteDataSource _remote;

  QuoteRepository(this._remote);

  Future<List<Quote>> getQuotes({
    required String userId,
    required int page,
  }) {
    return _remote.fetchQuotes(
      userId: userId,
      page: page,
    );
  }

  Future<Quote> getQuoteOfTheDay({
    required String userId,
  }) {
    return _remote.fetchQuoteOfTheDay(
      userId: userId,
    );
  }

  Future<void> toggleFavorite({
    required String userId,
    required Quote quote,
  }) async {
    if (quote.isFavorite) {
      await _remote.removeFavorite(
        userId: userId,
        quoteId: quote.id,
      );
    } else {
      await _remote.addFavorite(
        userId: userId,
        quoteId: quote.id,
      );
    }
  }
}
