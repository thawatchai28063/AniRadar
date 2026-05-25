import 'package:flutter/material.dart';

import '../screens/anime/anime_list_page.dart';
import '../screens/anime/anime_search_page.dart';

class AniRadarApp extends StatelessWidget {
  const AniRadarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AniRadar',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF8F5FF),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF7C3AED),
          brightness: Brightness.light,
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Color(0xFFF8F5FF),
          foregroundColor: Color(0xFF1E1B4B),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xFFE9D5FF)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xFF7C3AED), width: 1.4),
          ),
          filled: true,
          fillColor: const Color(0xFFFCFAFF),
        ),
        useMaterial3: true,
      ),
      home: const AniRadarHomePage(),
    );
  }
}

class AniRadarHomePage extends StatelessWidget {
  const AniRadarHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('AniRadar'),
          bottom: const TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.center,
            labelPadding: EdgeInsets.symmetric(horizontal: 14),
            tabs: <Widget>[
              Tab(icon: Icon(Icons.play_circle_outline), text: 'กำลังฉาย'),
              Tab(icon: Icon(Icons.auto_awesome), text: 'เร็ว ๆ นี้'),
              Tab(icon: Icon(Icons.calendar_month_outlined), text: 'ตารางฉาย'),
              Tab(icon: Icon(Icons.search), text: 'ค้นหา'),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            AnimeListPage(
              title: 'อนิเมะกำลังฉาย',
              subtitle: 'อัปเดตเรื่องที่กำลังออกอากาศจาก MyAnimeList',
              type: AnimeFeedType.now,
            ),
            AnimeListPage(
              title: 'อนิเมะเร็ว ๆ นี้',
              subtitle: 'ดูรายชื่อเรื่องใหม่ที่กำลังจะมาในซีซั่นถัดไป',
              type: AnimeFeedType.upcoming,
            ),
            AnimeListPage(
              title: 'ตารางฉายรายสัปดาห์',
              subtitle: 'รวมอนิเมะตามตารางออกอากาศประจำสัปดาห์',
              type: AnimeFeedType.schedule,
            ),
            AnimeSearchPage(),
          ],
        ),
      ),
    );
  }
}
