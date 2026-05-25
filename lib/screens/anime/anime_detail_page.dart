import 'package:flutter/material.dart';

import '../../models/anime.dart';
import '../../widgets/anime_poster.dart';

class AnimeDetailPage extends StatelessWidget {
  const AnimeDetailPage({super.key, required this.anime});

  final Anime anime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F5FF),
      appBar: AppBar(title: const Text('รายละเอียดอนิเมะ')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AnimePoster(imageUrl: anime.imageUrl, width: 132, height: 188),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      anime.title,
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(
                            color: const Color(0xFF1E1B4B),
                            fontWeight: FontWeight.w900,
                          ),
                    ),
                    if (anime.titleJapanese.isNotEmpty) ...<Widget>[
                      const SizedBox(height: 6),
                      Text(
                        anime.titleJapanese,
                        style: const TextStyle(color: Color(0xFF6B7280)),
                      ),
                    ],
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: <Widget>[
                        _DetailChip(
                          icon: Icons.star_rounded,
                          label: anime.score == null
                              ? 'ยังไม่มีคะแนน'
                              : '${anime.score!.toStringAsFixed(1)} คะแนน',
                        ),
                        if (anime.episodes != null)
                          _DetailChip(
                            icon: Icons.live_tv_outlined,
                            label: '${anime.episodes} ตอน',
                          ),
                        if (anime.year != null)
                          _DetailChip(
                            icon: Icons.calendar_month_outlined,
                            label: anime.year.toString(),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          _SectionCard(
            title: 'ข้อมูลการฉาย',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _InfoLine(label: 'สถานะ', value: anime.status),
                if (anime.broadcast.isNotEmpty)
                  _InfoLine(label: 'เวลาออกอากาศ', value: anime.broadcast),
                if (anime.rating.isNotEmpty)
                  _InfoLine(label: 'เรตติ้ง', value: anime.rating),
                if (anime.season.isNotEmpty)
                  _InfoLine(label: 'ซีซั่น', value: anime.season),
              ],
            ),
          ),
          const SizedBox(height: 14),
          if (anime.genres.isNotEmpty)
            _SectionCard(
              title: 'แนว',
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: anime.genres
                    .map(
                      (String genre) => Chip(
                        label: Text(genre),
                        backgroundColor: const Color(0xFFF3E8FF),
                      ),
                    )
                    .toList(),
              ),
            ),
          const SizedBox(height: 14),
          _SectionCard(
            title: 'เรื่องย่อ',
            child: Text(
              anime.synopsis,
              style: const TextStyle(height: 1.45, color: Color(0xFF374151)),
            ),
          ),
          if (anime.trailerUrl.isNotEmpty) ...<Widget>[
            const SizedBox(height: 14),
            _SectionCard(
              title: 'Trailer',
              child: Text(
                anime.trailerUrl,
                style: const TextStyle(
                  color: Color(0xFF7C3AED),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFE9D5FF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w900,
              color: const Color(0xFF1E1B4B),
            ),
          ),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}

class _InfoLine extends StatelessWidget {
  const _InfoLine({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 110,
            child: Text(
              label,
              style: const TextStyle(color: Color(0xFF6B7280)),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailChip extends StatelessWidget {
  const _DetailChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: const Color(0xFFF3E8FF),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, size: 16, color: const Color(0xFF7C3AED)),
          const SizedBox(width: 5),
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF4C1D95),
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}
