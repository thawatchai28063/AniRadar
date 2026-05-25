import 'package:flutter/material.dart';

import '../../models/anime.dart';
import '../../services/jikan_service.dart';
import '../../widgets/anime_card.dart';

class AnimeSearchPage extends StatefulWidget {
  const AnimeSearchPage({super.key});

  @override
  State<AnimeSearchPage> createState() => _AnimeSearchPageState();
}

class _AnimeSearchPageState extends State<AnimeSearchPage> {
  final _service = JikanService();
  final _searchController = TextEditingController();
  Future<List<Anime>>? _searchFuture;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _search() {
    final keyword = _searchController.text.trim();
    if (keyword.isEmpty) return;
    setState(() => _searchFuture = _service.searchAnime(keyword));
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: const Color(0xFFE9D5FF)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'ค้นหาอนิเมะ',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFF1E1B4B),
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'พิมพ์ชื่อเรื่องที่อยากดู แล้วกดค้นหา',
                style: TextStyle(color: Color(0xFF6B7280)),
              ),
              const SizedBox(height: 14),
              TextField(
                controller: _searchController,
                textInputAction: TextInputAction.search,
                onSubmitted: (_) => _search(),
                decoration: InputDecoration(
                  hintText: 'เช่น One Piece, Naruto, Frieren',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    onPressed: _search,
                    icon: const Icon(Icons.arrow_forward),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        if (_searchFuture == null)
          const _EmptySearch()
        else
          FutureBuilder<List<Anime>>(
            future: _searchFuture,
            builder:
                (BuildContext context, AsyncSnapshot<List<Anime>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Padding(
                      padding: EdgeInsets.all(24),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  if (snapshot.hasError) {
                    return const _SearchMessage(
                      icon: Icons.wifi_off_outlined,
                      text: 'ค้นหาไม่ได้ ลองตรวจสอบอินเทอร์เน็ต',
                    );
                  }

                  final results = snapshot.data ?? <Anime>[];
                  if (results.isEmpty) {
                    return const _SearchMessage(
                      icon: Icons.search_off_outlined,
                      text: 'ไม่พบอนิเมะที่ค้นหา',
                    );
                  }

                  return Column(
                    children: results
                        .map(
                          (Anime anime) => Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: AnimeCard(anime: anime),
                          ),
                        )
                        .toList(),
                  );
                },
          ),
      ],
    );
  }
}

class _EmptySearch extends StatelessWidget {
  const _EmptySearch();

  @override
  Widget build(BuildContext context) {
    return const _SearchMessage(
      icon: Icons.movie_filter_outlined,
      text: 'ค้นหาอนิเมะจากฐานข้อมูล MyAnimeList ผ่าน Jikan API',
    );
  }
}

class _SearchMessage extends StatelessWidget {
  const _SearchMessage({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFE9D5FF)),
      ),
      child: Column(
        children: <Widget>[
          Icon(icon, size: 42, color: const Color(0xFF7C3AED)),
          const SizedBox(height: 10),
          Text(text, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
