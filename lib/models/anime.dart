class Anime {
  const Anime({
    required this.id,
    required this.title,
    required this.titleJapanese,
    required this.imageUrl,
    required this.trailerUrl,
    required this.synopsis,
    required this.score,
    required this.episodes,
    required this.status,
    required this.rating,
    required this.season,
    required this.year,
    required this.broadcast,
    required this.genres,
  });

  final int id;
  final String title;
  final String titleJapanese;
  final String imageUrl;
  final String trailerUrl;
  final String synopsis;
  final double? score;
  final int? episodes;
  final String status;
  final String rating;
  final String season;
  final int? year;
  final String broadcast;
  final List<String> genres;

  factory Anime.fromJson(Map<String, dynamic> json) {
    final images = json['images'] as Map<String, dynamic>?;
    final jpg = images?['jpg'] as Map<String, dynamic>?;
    final trailer = json['trailer'] as Map<String, dynamic>?;
    final broadcast = json['broadcast'] as Map<String, dynamic>?;
    final genres = (json['genres'] as List<dynamic>? ?? <dynamic>[])
        .map((dynamic item) => item as Map<String, dynamic>)
        .map((Map<String, dynamic> item) => item['name'] as String? ?? '')
        .where((String name) => name.isNotEmpty)
        .toList();

    return Anime(
      id: json['mal_id'] as int? ?? 0,
      title: json['title'] as String? ?? 'Untitled',
      titleJapanese: json['title_japanese'] as String? ?? '',
      imageUrl:
          jpg?['large_image_url'] as String? ??
          jpg?['image_url'] as String? ??
          '',
      trailerUrl: trailer?['url'] as String? ?? '',
      synopsis: json['synopsis'] as String? ?? 'ยังไม่มีเรื่องย่อ',
      score: (json['score'] as num?)?.toDouble(),
      episodes: json['episodes'] as int?,
      status: json['status'] as String? ?? 'Unknown',
      rating: json['rating'] as String? ?? '',
      season: json['season'] as String? ?? '',
      year: json['year'] as int?,
      broadcast: broadcast?['string'] as String? ?? '',
      genres: genres,
    );
  }
}
