// class Quote {
//   final String id;
//   final String text;
//   final String author;
//   final String category;
//   final String wikiKey;
//   final bool isFavorite;
//   final bool isImageQuote;

//   Quote({
//     required this.id,
//     required this.text,
//     required this.author,
//     required this.category,
//     required this.wikiKey,
//     this.isFavorite = false,
//     this.isImageQuote = false,
//   });

//   factory Quote.fromMap(
//     Map<String, dynamic> map, {
//     bool isFavorite = false,
//   }) {
//     return Quote(
//       id: map['id'] as String,
//       text: map['quote'] as String,
//       author: map['name'] as String,
//       category: map['category'] as String,
//       wikiKey: map['wiki_key'] as String,
//       isFavorite: isFavorite,
//       isImageQuote: map['is_image_quote'] ?? false,
//     );
//   }

//   Quote copyWith({
//     bool? isFavorite,
//   }) {
//     return Quote(
//       id: id,
//       text: text,
//       author: author,
//       category: category,
//       wikiKey: wikiKey,
//       isFavorite: isFavorite ?? this.isFavorite,
//       isImageQuote: isImageQuote,
//     );
//   }
// }
import 'dart:convert';

class Quote {
  final String id;
  final String text;
  final String author;
  final String category;
  final String wikiKey;
  final bool isFavorite;
  final bool isImageQuote;

  Quote({
    required this.id,
    required this.text,
    required this.author,
    required this.category,
    required this.wikiKey,
    this.isFavorite = false,
    this.isImageQuote = false,
  });

  factory Quote.fromMap(
    Map<String, dynamic> map, {
    bool isFavorite = false,
  }) {
    return Quote(
      id: map['id'] as String,
      text: map['quote'] as String,
      author: map['name'] as String,
      category: map['category'] as String,
      wikiKey: map['wiki_key'] as String,
      isFavorite: isFavorite,
      isImageQuote: map['is_image_quote'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'quote': text,
      'name': author,
      'category': category,
      'wiki_key': wikiKey,
      'is_image_quote': isImageQuote,
      'isFavorite': isFavorite,
    };
  }

  String toJson() => jsonEncode(toMap());

  factory Quote.fromJson(String source) =>
      Quote.fromMap(json.decode(source) as Map<String, dynamic>);

  Quote copyWith({
    bool? isFavorite,
  }) {
    return Quote(
      id: id,
      text: text,
      author: author,
      category: category,
      wikiKey: wikiKey,
      isFavorite: isFavorite ?? this.isFavorite,
      isImageQuote: isImageQuote,
    );
  }
}