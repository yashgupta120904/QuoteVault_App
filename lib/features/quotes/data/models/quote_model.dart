class Quote {
  final String text;
  final String author;
  final String genre;
  final bool isFavorite;
  final bool isImageQuote;

  Quote({
    required this.text,
    required this.author,
    required this.genre,
    required this.isFavorite,
    this.isImageQuote = false,
  });
}