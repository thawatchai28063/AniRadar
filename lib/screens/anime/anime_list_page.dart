import 'package:flutter/material.dart';

import '../../models/anime.dart';
import '../../services/jikan_service.dart';
import '../../widgets/anime_card.dart';

enum AnimeFeedType { now, upcoming, schedule }

class AnimeListPage extends StatefulWidget {
  const AnimeListPage({
    super.key,
    required this.title,
    required this.subtitle,
    required this.type,
  });

  final String title;
  final String subtitle;
  final AnimeFeedType type;

  @override
  State<AnimeListPage> createState() => _AnimeListPageState();
}

class _AnimeListPageState extends State<AnimeListPage> {
  final JikanService _service = JikanService();
  late Future<List<Anime>> _animeFuture;

  @override
  void initState() {
    super.initState();
    _animeFuture = _load();
  }

  Future<List<Anime>> _load() {
    return switch (widget.type) {
      AnimeFeedType.now => _service.fetchNowAiring(),
      AnimeFeedType.upcoming => _service.fetchUpcoming(),
      AnimeFeedType.schedule => _service.fetchSchedule(),
    };
  }

  void _refresh() {
    setState(() => _animeFuture = _load());
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => _refresh(),
      child: FutureBuilder<List<Anime>>(
        future: _animeFuture,
        builder: (BuildContext context, AsyncSnapshot<List<Anime>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return ListView(
              padding: const EdgeInsets.all(20),
              children: <Widget>[
                _HeroHeader(title: widget.title, subtitle: widget.subtitle),
                const SizedBox(height: 16),
                _ErrorPanel(onRetry: _refresh),
              ],
            );
          }

          final animeList = snapshot.data ?? <Anime>[];
          return ListView.separated(
            padding: const EdgeInsets.all(20),
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return _HeroHeader(
                  title: widget.title,
                  subtitle: widget.subtitle,
                );
              }
              return AnimeCard(anime: animeList[index - 1]);
            },
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemCount: animeList.length + 1,
          );
        },
      ),
    );
  }
}

class _HeroHeader extends StatelessWidget {
  const _HeroHeader({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[Color(0xFF312E81), Color(0xFF7C3AED)],
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: const Color(0xFF7C3AED).withValues(alpha: 0.22),
            blurRadius: 28,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          const Icon(Icons.auto_awesome, color: Colors.white, size: 40),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(color: Colors.white70, height: 1.35),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ErrorPanel extends StatelessWidget {
  const _ErrorPanel({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFE9D5FF)),
      ),
      child: Column(
        children: <Widget>[
          const Icon(Icons.wifi_off_outlined, color: Color(0xFF7C3AED)),
          const SizedBox(height: 10),
          const Text('โหลดข้อมูลอนิเมะไม่ได้'),
          const SizedBox(height: 12),
          FilledButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh),
            label: const Text('ลองใหม่'),
          ),
        ],
      ),
    );
  }
}
