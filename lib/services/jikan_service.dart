import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/anime.dart';

class JikanService {
  JikanService({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;
  static const String _host = 'api.jikan.moe';

  Future<List<Anime>> fetchNowAiring() {
    return _fetchAnimeList('/v4/seasons/now', <String, String>{
      'sfw': 'true',
      'limit': '20',
    });
  }

  Future<List<Anime>> fetchUpcoming() {
    return _fetchAnimeList('/v4/seasons/upcoming', <String, String>{
      'sfw': 'true',
      'limit': '20',
    });
  }

  Future<List<Anime>> fetchSchedule({String? day}) {
    final query = <String, String>{'sfw': 'true', 'limit': '20'};
    if (day != null) query['filter'] = day;
    return _fetchAnimeList('/v4/schedules', query);
  }

  Future<List<Anime>> searchAnime(String keyword) {
    return _fetchAnimeList('/v4/anime', <String, String>{
      'q': keyword,
      'sfw': 'true',
      'limit': '20',
      'order_by': 'popularity',
    });
  }

  Future<List<Anime>> _fetchAnimeList(
    String path,
    Map<String, String> query,
  ) async {
    final uri = Uri.https(_host, path, query);
    final response = await _client.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Jikan API error: ${response.statusCode}');
    }

    final decoded = jsonDecode(response.body) as Map<String, dynamic>;
    final data = decoded['data'] as List<dynamic>? ?? <dynamic>[];
    return data
        .map((dynamic item) => Anime.fromJson(item as Map<String, dynamic>))
        .where((Anime anime) => anime.id != 0)
        .toList();
  }
}
