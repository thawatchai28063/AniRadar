# Codex Handoff: AniRadar

Use this file when moving the project to another machine or opening it in a fresh Codex session.

## Repository

```text
https://github.com/thawatchai28063/AniRadar.git
```

Clone:

```powershell
git clone https://github.com/thawatchai28063/AniRadar.git
cd AniRadar
```

## Setup on a New Machine

Requirements:

- Flutter stable SDK
- Android Studio or Android SDK
- A connected Android device or emulator

Install dependencies:

```powershell
flutter pub get
```

Check devices:

```powershell
flutter devices
```

Run:

```powershell
flutter run
```

Build release APK:

```powershell
flutter build apk
```

Install release APK:

```powershell
flutter install -d DEVICE_ID
```

## Validation

Before pushing changes:

```powershell
dart format lib test
flutter analyze
flutter test
```

Current expected test result:

```text
All tests passed
```

## App Summary

AniRadar is a Flutter anime browser powered by Jikan API.

Main flows:

- `กำลังฉาย`: currently airing anime
- `เร็ว ๆ นี้`: upcoming anime
- `ตารางฉาย`: weekly schedule
- `ค้นหา`: search anime by keyword
- Detail page: poster, score, episodes, status, genres, synopsis, trailer URL

## API Details

API docs:

```text
https://docs.api.jikan.moe/
```

Base URL:

```text
https://api.jikan.moe/v4
```

Endpoints used:

```text
/seasons/now
/seasons/upcoming
/schedules
/anime?q=keyword
```

No API key is required.

## Project Map

```text
lib/
  app/
    ani_radar_app.dart
  models/
    anime.dart
  screens/
    anime/
      anime_detail_page.dart
      anime_list_page.dart
      anime_search_page.dart
  services/
    jikan_service.dart
  widgets/
    anime_card.dart
    anime_poster.dart
  main.dart
```

## Notes for Future Codex Work

- Keep this as a no-login app unless the user explicitly asks for accounts.
- Preserve the simple app structure.
- Keep network image fallbacks.
- If Jikan rate limits, show retry/error UI instead of crashing.
- If changing app name/icon, update Android label and mipmap launcher icons.
