// import 'package:supabase_flutter/supabase_flutter.dart';

// import '../../../quotes/data/models/quote_model.dart';
// import '../models/author_model.dart';
// import '../datasources/explore_remote_datasource.dart';

// class ExploreRepository {
//   final ExploreRemoteDataSource _remote;

//   ExploreRepository()
//       : _remote = ExploreRemoteDataSource(
//           Supabase.instance.client,
//         );

//   // ---------------- Categories ----------------
//   Future<List<String>> fetchCategories() async {
//     final categories = await _remote.fetchCategories();
//     return ['All Topics', ...categories];
//   }

//   // ---------------- Quotes ----------------
//   Future<List<Quote>> fetchQuotesByCategory({
//     required String userId,
//     required String category,
//   }) async {
//     final quotesRaw = await _remote.fetchQuotes(
//       category: category,
//     );

//     final favoriteIds =
//         await _remote.fetchFavoriteQuoteIds(userId);

//     return quotesRaw.map<Quote>((q) {
//       return Quote.fromMap(
//         q,
//         isFavorite: favoriteIds.contains(q['id']),
//       );
//     }).toList();
//   }

//   // ---------------- Favorites (🔥 REQUIRED FIX) ----------------
//   Future<void> toggleFavorite({
//     required String userId,
//     required Quote quote,
//   }) async {
//     if (quote.isFavorite) {
//       await _remote.removeFavorite(
//         userId: userId,
//         quoteId: quote.id,
//       );
//     } else {
//       await _remote.addFavorite(
//         userId: userId,
//         quoteId: quote.id,
//       );
//     }
//   }

//   // ---------------- Trending Authors ----------------
//   Future<List<Author>> fetchTrendingAuthors(
//     String category,
//   ) async {
//     final rawAuthors =
//         await _remote.fetchTrendingAuthors(category);

//     return rawAuthors.map<Author>((e) {
//       return Author(
//         name: e['name'],
//         category: e['category'],
//         wikiKey: e['wiki_key'],
//       );
//     }).toList();
//   }
// }
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../quotes/data/models/quote_model.dart';
import '../models/author_model.dart';
import '../datasources/explore_remote_datasource.dart';

class ExploreRepository {
  final ExploreRemoteDataSource _remote;

  ExploreRepository()
      : _remote = ExploreRemoteDataSource(
          Supabase.instance.client,
        );

  // ---------------- Categories ----------------
  Future<List<String>> fetchCategories() async {
    final categories = await _remote.fetchCategories();
    return ['All Topics', ...categories];
  }

  // ---------------- Quotes ----------------
  Future<List<Quote>> fetchQuotesByCategory({
    required String userId,
    required String category,
    int page = 0,
    int limit = 10,
  }) async {
    final quotesRaw = await _remote.fetchQuotes(
      category: category,
      page: page,
      limit: limit,
    );

    final favoriteIds =
        await _remote.fetchFavoriteQuoteIds(userId);

    return quotesRaw.map<Quote>((q) {
      return Quote.fromMap(
        q,
        isFavorite: favoriteIds.contains(q['id']),
      );
    }).toList();
  }

  // ---------------- Favorites ----------------
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

  // ---------------- Trending Authors ----------------
  Future<List<Author>> fetchTrendingAuthors(
    String category,
  ) async {
    final rawAuthors =
        await _remote.fetchTrendingAuthors(category);

    return rawAuthors.map<Author>((e) {
      return Author(
        name: e['name'],
        category: e['category'],
        wikiKey: e['wiki_key'],
      );
    }).toList();
  }
}