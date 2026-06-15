# Codex Notes for AniRadar

This repository is a Flutter app named `AniRadar`.

## Current App

- App type: anime browser / tracker-style app
- API: Jikan API, free and no API key required
- Android label: `AniRadar`
- Main entry: `lib/main.dart`
- App shell: `lib/app/ani_radar_app.dart`

## Important Files

- `lib/models/anime.dart`: anime data model parsed from Jikan JSON
- `lib/services/jikan_service.dart`: REST calls to Jikan API
- `lib/screens/anime/anime_list_page.dart`: now/upcoming/schedule list UI
- `lib/screens/anime/anime_search_page.dart`: search UI
- `lib/screens/anime/anime_detail_page.dart`: detail UI
- `lib/widgets/anime_card.dart`: list item card
- `lib/widgets/anime_poster.dart`: poster image widget with fallback

## Commands to Validate Changes

Run these before committing:

```powershell
dart format lib test
flutter analyze
flutter test
```

For Android APK:

```powershell
flutter build apk
```

For device install:

```powershell
flutter devices
flutter install -d DEVICE_ID
```

## Coding Notes

- Keep the app usable without login.
- Do not add API keys; Jikan does not require one.
- Use `Image.network(..., errorBuilder: ...)` for remote posters to avoid broken image crashes.
- Keep UI text Thai-friendly; current UX labels are mostly Thai.
- If adding new anime feeds, prefer extending `JikanService` and reusing `AnimeListPage`.
- If launcher icon changes, update `android/app/src/main/res/mipmap-*/ic_launcher.png`.

## GitHub

Remote repository:

```text
https://github.com/thawatchai28063/AniRadar.git
```
