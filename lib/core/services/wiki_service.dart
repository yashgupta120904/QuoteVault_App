import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class WikiService {
  static final Map<String, String?> _imageCache = {};

  /// Base URL from .env
  /// Example:
  /// WIKI_URL=https://en.wikipedia.org/api/rest_v1/page/summary/
  static String get _baseUrl =>
      dotenv.env['WIKI_URL'] ??
      'https://en.wikipedia.org/api/rest_v1/page/summary/';

  static Future<String?> getAuthorImage(String wikiKey) async {
    // 1️⃣ Return cached result if exists
    if (_imageCache.containsKey(wikiKey)) {
      return _imageCache[wikiKey];
    }

    // 2️⃣ Encode wiki key safely
    final encodedKey = Uri.encodeComponent(wikiKey);
    final uri = Uri.parse('$_baseUrl$encodedKey');

    try {
      final response = await http.get(
        uri,
        headers: {
          'User-Agent': 'QuoteVault/1.0 (contact@quotevault.app)',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final imageUrl = data['thumbnail']?['source'] as String?;

        // 3️⃣ Cache result (even null to avoid repeat calls)
        _imageCache[wikiKey] = imageUrl;
        return imageUrl;
      }
    } catch (e) {
      // Optional: log error
    }

    return null;
  }
}
