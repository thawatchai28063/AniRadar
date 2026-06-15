# AniRadar

AniRadar is a Flutter mobile app for browsing anime data from the free Jikan API.

## Features

- Now airing anime
- Upcoming anime
- Weekly anime schedule
- Anime search
- Detail page with poster, score, episodes, status, genres, synopsis, and trailer URL
- Custom Android launcher icon

## API

This app uses Jikan API, a free REST API for MyAnimeList data.

- Docs: https://docs.api.jikan.moe/
- Base URL: `https://api.jikan.moe/v4`

Used endpoints:

- `/seasons/now`
- `/seasons/upcoming`
- `/schedules`
- `/anime?q=keyword`

## Project Structure

```text
lib/
  app/ani_radar_app.dart
  main.dart
  models/anime.dart
  screens/anime/anime_detail_page.dart
  screens/anime/anime_list_page.dart
  screens/anime/anime_search_page.dart
  services/jikan_service.dart
  widgets/anime_card.dart
  widgets/anime_poster.dart
```

## Common Commands

```powershell
flutter pub get
flutter analyze
flutter test
flutter run
flutter build apk
```

## Android Install

```powershell
flutter devices
flutter install -d DEVICE_ID
```

If Android shows the old icon, uninstall the app from the phone and install again.
