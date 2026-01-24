// // // import 'package:supabase_flutter/supabase_flutter.dart';

// // // class ExploreRemoteDataSource {
// // //   final SupabaseClient _client;

// // //   ExploreRemoteDataSource(this._client);

// // //   // ---------------- Categories ----------------
// // //   Future<List<String>> fetchCategories() async {
// // //     final res = await _client.from('quotes').select('category');

// // //     final categories =
// // //         res.map<String>((e) => e['category'] as String).toSet().toList();

// // //     categories.sort();
// // //     return categories;
// // //   }

// // //   // ---------------- Quotes ----------------
// // //   Future<List<Map<String, dynamic>>> fetchQuotes({
// // //     required String category,
// // //     int limit = 10,
// // //   }) async {
// // //     final query = _client.from('quotes').select();

// // //     if (category != 'All Topics') {
// // //       query.eq('category', category);
// // //     }

// // //     return await query.limit(limit);
// // //   }

// // //   // ---------------- Favorites ----------------
// // //   Future<Set<String>> fetchFavoriteQuoteIds(String userId) async {
// // //     final res = await _client
// // //         .from('user_favorites')
// // //         .select('quote_id')
// // //         .eq('user_id', userId);

// // //     return res.map<String>((e) => e['quote_id'] as String).toSet();
// // //   }

// // //   Future<void> addFavorite({
// // //     required String userId,
// // //     required String quoteId,
// // //   }) async {
// // //     await _client.from('user_favorites').insert({
// // //       'user_id': userId,
// // //       'quote_id': quoteId,
// // //     });
// // //   }

// // //   Future<void> removeFavorite({
// // //     required String userId,
// // //     required String quoteId,
// // //   }) async {
// // //     await _client.from('user_favorites').delete().match({
// // //       'user_id': userId,
// // //       'quote_id': quoteId,
// // //     });
// // //   }

// // //   // ---------------- Trending Authors ----------------
// // //   Future<List<Map<String, dynamic>>> fetchTrendingAuthors(
// // //     String category,
// // //   ) async {
// // //     final query =
// // //         _client.from('quotes').select('name, category, wiki_key');

// // //     if (category != 'All Topics') {
// // //       query.eq('category', category);
// // //     }

// // //     return await query.limit(4);
// // //   }
// // // }
// // // import 'package:supabase_flutter/supabase_flutter.dart';

// // // class ExploreRemoteDataSource {
// // //   final SupabaseClient _client;

// // //   ExploreRemoteDataSource(this._client);

// // //   // ---------------- Categories ----------------
// // //   Future<List<String>> fetchCategories() async {
// // //     final res = await _client.from('quotes').select('category').distinct();

// // //     final categories =
// // //         res.map<String>((e) => e['category'] as String).toSet().toList();

// // //     categories.sort();
// // //     return categories;
// // //   }

// // //   // ---------------- Quotes ----------------
// // //   Future<List<Map<String, dynamic>>> fetchQuotes({
// // //     required String category,
// // //     int limit = 10,
// // //   }) async {
// // //     final query = _client.from('quotes').select();

// // //     if (category != 'All Topics') {
// // //       query.eq('category', category);
// // //     }

// // //     return await query.limit(limit);
// // //   }

// // //   // ---------------- Favorites ----------------
// // //   Future<Set<String>> fetchFavoriteQuoteIds(String userId) async {
// // //     final res = await _client
// // //         .from('user_favorites')
// // //         .select('quote_id')
// // //         .eq('user_id', userId);

// // //     return res.map<String>((e) => e['quote_id'] as String).toSet();
// // //   }

// // //   Future<void> addFavorite({
// // //     required String userId,
// // //     required String quoteId,
// // //   }) async {
// // //     await _client.from('user_favorites').upsert(
// // //       {
// // //         'user_id': userId,
// // //         'quote_id': quoteId,
// // //       },
// // //       onConflict: 'user_id,quote_id',
// // //     );
// // //   }

// // //   Future<void> removeFavorite({
// // //     required String userId,
// // //     required String quoteId,
// // //   }) async {
// // //     await _client.from('user_favorites').delete().match({
// // //       'user_id': userId,
// // //       'quote_id': quoteId,
// // //     });
// // //   }

// // //   // ---------------- Trending Authors ----------------
// // //   Future<List<Map<String, dynamic>>> fetchTrendingAuthors(
// // //     String category,
// // //   ) async {
// // //     if (category == 'All Topics') {
// // //       // Random 4 authors from all categories
// // //       final res = await _client
// // //           .from('quotes')
// // //           .select('name, category, wiki_key')
// // //           .order('RANDOM()')
// // //           .limit(4);
// // //       return res;
// // //     } else {
// // //       // Get 4 authors from selected category
// // //       final res = await _client
// // //           .from('quotes')
// // //           .select('name, category, wiki_key')
// // //           .eq('category', category)
// // //           .order('RANDOM()')
// // //           .limit(4);
// // //       return res;
// // //     }
// // //   }
// // // }

// // import 'package:supabase_flutter/supabase_flutter.dart';

// // class ExploreRemoteDataSource {
// //   final SupabaseClient _client;

// //   ExploreRemoteDataSource(this._client);

// //   // ---------------- Categories ----------------
// //   Future<List<String>> fetchCategories() async {
// //     final res = await _client.from('quotes').select('category');

// //     final categories = res
// //         .map<String>((e) => e['category'] as String)
// //         .toSet()
// //         .toList();

// //     categories.sort();
// //     return categories;
// //   }

// //   // ---------------- Quotes ----------------
// //   Future<List<Map<String, dynamic>>> fetchQuotes({
// //     required String category,
// //     int limit = 10,
// //   }) async {
// //     final query = _client.from('quotes').select();

// //     if (category != 'All Topics') {
// //       query.eq('category', category);
// //     }

// //     return await query.limit(limit);
// //   }

// //   // ---------------- Favorites ----------------
// //   Future<Set<String>> fetchFavoriteQuoteIds(String userId) async {
// //     final res = await _client
// //         .from('user_favorites')
// //         .select('quote_id')
// //         .eq('user_id', userId);

// //     return res.map<String>((e) => e['quote_id'] as String).toSet();
// //   }

// //   Future<void> addFavorite({
// //     required String userId,
// //     required String quoteId,
// //   }) async {
// //     await _client.from('user_favorites').upsert(
// //       {
// //         'user_id': userId,
// //         'quote_id': quoteId,
// //       },
// //       onConflict: 'user_id,quote_id',
// //     );
// //   }

// //   Future<void> removeFavorite({
// //     required String userId,
// //     required String quoteId,
// //   }) async {
// //     await _client.from('user_favorites').delete().match({
// //       'user_id': userId,
// //       'quote_id': quoteId,
// //     });
// //   }

// //   // ---------------- Trending Authors ----------------
// //   Future<List<Map<String, dynamic>>> fetchTrendingAuthors(
// //     String category,
// //   ) async {
// //     if (category == 'All Topics') {
// //       // Random 4 authors from all categories
// //       final res = await _client
// //           .from('quotes')
// //           .select('name, category, wiki_key')
// //           .order('RANDOM()')
// //           .limit(4);
// //       return res;
// //     } else {
// //       // Get 4 authors from selected category
// //       final res = await _client
// //           .from('quotes')
// //           .select('name, category, wiki_key')
// //           .eq('category', category)
// //           .order('RANDOM()')
// //           .limit(4);
// //       return res;
// //     }
// //   }
// // }
// import 'package:supabase_flutter/supabase_flutter.dart';

// class ExploreRemoteDataSource {
//   final SupabaseClient _client;

//   ExploreRemoteDataSource(this._client);

//   // ---------------- Categories ----------------
//   Future<List<String>> fetchCategories() async {
//     final res = await _client.from('quotes').select('category');

//     final categories = res
//         .map<String>((e) => e['category'] as String)
//         .toSet()
//         .toList();

//     categories.sort();
//     return categories;
//   }

//   // ---------------- Quotes ----------------
//   Future<List<Map<String, dynamic>>> fetchQuotes({
//     required String category,
//     int limit = 10,
//   }) async {
//     if (category == 'All Topics') {
//       // Fetch all quotes
//       return await _client
//           .from('quotes')
//           .select()
//           .limit(limit);
//     } else {
//       // Fetch quotes for specific category (case-insensitive match)
//       return await _client
//           .from('quotes')
//           .select()
//           .ilike('category', category)
//           .limit(limit);
//     }
//   }

//   // ---------------- Favorites ----------------
//   Future<Set<String>> fetchFavoriteQuoteIds(String userId) async {
//     final res = await _client
//         .from('user_favorites')
//         .select('quote_id')
//         .eq('user_id', userId);

//     return res.map<String>((e) => e['quote_id'] as String).toSet();
//   }

//   Future<void> addFavorite({
//     required String userId,
//     required String quoteId,
//   }) async {
//     await _client.from('user_favorites').upsert(
//       {
//         'user_id': userId,
//         'quote_id': quoteId,
//       },
//       onConflict: 'user_id,quote_id',
//     );
//   }

//   Future<void> removeFavorite({
//     required String userId,
//     required String quoteId,
//   }) async {
//     await _client.from('user_favorites').delete().match({
//       'user_id': userId,
//       'quote_id': quoteId,
//     });
//   }

//   // ---------------- Trending Authors ----------------
//   Future<List<Map<String, dynamic>>> fetchTrendingAuthors(
//     String category,
//   ) async {
//     if (category == 'All Topics') {
//       // Random 4 authors from all categories
//       final res = await _client
//           .from('quotes')
//           .select('name, category, wiki_key')
//           .limit(4);
      
//       // Remove duplicates by name
//       final seen = <String>{};
//       final unique = <Map<String, dynamic>>[];
//       for (var author in res) {
//         if (!seen.contains(author['name'])) {
//           seen.add(author['name']);
//           unique.add(author);
//         }
//       }
//       return unique.length >= 4 ? unique.sublist(0, 4) : unique;
//     } else {
//       // Get 4 authors from selected category
//       final res = await _client
//           .from('quotes')
//           .select('name, category, wiki_key')
//           .eq('category', category)
//           .limit(10);
      
//       // Remove duplicates by name
//       final seen = <String>{};
//       final unique = <Map<String, dynamic>>[];
//       for (var author in res) {
//         if (!seen.contains(author['name'])) {
//           seen.add(author['name']);
//           unique.add(author);
//         }
//       }
//       return unique.length >= 4 ? unique.sublist(0, 4) : unique;
//     }
//   }
// }

import 'package:supabase_flutter/supabase_flutter.dart';

class ExploreRemoteDataSource {
  final SupabaseClient _client;

  ExploreRemoteDataSource(this._client);

  // ---------------- Categories ----------------
  Future<List<String>> fetchCategories() async {
    final res = await _client.from('quotes').select('category');

    final categories = res
        .map<String>((e) => e['category'] as String)
        .toSet()
        .toList();

    categories.sort();
    return categories;
  }

  // ---------------- Quotes ----------------
  Future<List<Map<String, dynamic>>> fetchQuotes({
    required String category,
    int page = 0,
    int limit = 10,
  }) async {
    final offset = page * limit;
    
    if (category == 'All Topics') {
      // Fetch all quotes with pagination
      return await _client
          .from('quotes')
          .select()
          .range(offset, offset + limit - 1);
    } else {
      // Fetch quotes for specific category with pagination
      return await _client
          .from('quotes')
          .select()
          .ilike('category', category)
          .range(offset, offset + limit - 1);
    }
  }

  // ---------------- Favorites ----------------
  Future<Set<String>> fetchFavoriteQuoteIds(String userId) async {
    final res = await _client
        .from('user_favorites')
        .select('quote_id')
        .eq('user_id', userId);

    return res.map<String>((e) => e['quote_id'] as String).toSet();
  }

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

  // ---------------- Trending Authors ----------------
  Future<List<Map<String, dynamic>>> fetchTrendingAuthors(
    String category,
  ) async {
    if (category == 'All Topics') {
      // Random 4 authors from all categories
      final res = await _client
          .from('quotes')
          .select('name, category, wiki_key')
          .limit(4);
      
      // Remove duplicates by name
      final seen = <String>{};
      final unique = <Map<String, dynamic>>[];
      for (var author in res) {
        if (!seen.contains(author['name'])) {
          seen.add(author['name']);
          unique.add(author);
        }
      }
      return unique.length >= 4 ? unique.sublist(0, 4) : unique;
    } else {
      // Get 4 authors from selected category
      final res = await _client
          .from('quotes')
          .select('name, category, wiki_key')
          .eq('category', category)
          .limit(10);
      
      // Remove duplicates by name
      final seen = <String>{};
      final unique = <Map<String, dynamic>>[];
      for (var author in res) {
        if (!seen.contains(author['name'])) {
          seen.add(author['name']);
          unique.add(author);
        }
      }
      return unique.length >= 4 ? unique.sublist(0, 4) : unique;
    }
  }
}