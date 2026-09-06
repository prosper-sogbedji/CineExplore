# CineExplore

![CI](https://github.com/prosper-sogbedji/CineExplore/actions/workflows/ci.yml/badge.svg)
![Flutter](https://img.shields.io/badge/Flutter-3.44+-blue?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.12+-blue?logo=dart)
![License](https://img.shields.io/badge/license-MIT-green)

Application Flutter **production-ready** de découverte de films, construite avec une architecture Clean (Feature-First), une intégration API complète (TMDB + JWT), un cache SQLite et une suite de tests complète.

---

## Fonctionnalités

- 🎬 **Catalogue Connecté** : Films tendances et recherche via l'API **TMDB**
- 🔐 **Authentification JWT** : Login / Register avec token persisté (ReqRes.in)
- 📦 **Cache Hors-ligne** : Mode hors-ligne automatique via **SQLite** (`sqflite`)
- 🌗 **Thème Clair / Sombre** dynamique
- 🌐 **Internationalisation** : Support **FR 🇫🇷 + EN 🇬🇧**
- ♿ **Accessibilité** : `Semantics` labels sur tous les éléments interactifs
- ✅ **CI/CD** : Pipeline GitHub Actions (lint + tests automatiques)

---

## Architecture (Feature-First / Clean)

```
lib/
├── core/
│   ├── database/       # SQLite — DatabaseHelper
│   ├── l10n/           # Internationalisation (AppLocalizations FR/EN)
│   ├── network/        # Dio, AuthInterceptor, ApiConstants
│   ├── router/         # GoRouter avec Auth Guard
│   └── theme/          # ThemeController, AppTheme
├── features/
│   ├── auth/
│   │   ├── data/       # UserModel, AuthRepository
│   │   └── presentation/ # LoginScreen, RegisterScreen, SettingsScreen, AuthProvider
│   └── movies/
│       ├── data/       # Movie, MovieRepository, MovieDao
│       └── presentation/ # HomeScreen, MoviesScreen, MovieDetailScreen, MovieProvider
└── shared/
    └── widgets/        # MovieCard, MovieGrid, RatingBadge, EmptyState, AppScaffold
```

**Flux de données** : `UI → Provider → Repository → (Dio API | SQLite DAO)`

---

## Configuration (IMPORTANT)

> ⚠️ **Clé API TMDB requise** avant de lancer l'application.

1. Ouvrez `lib/core/network/api_constants.dart`
2. Remplacez `'VOTRE_CLE_API_TMDB_ICI'` par votre clé TMDB

**Compte de test (ReqRes.in)** :
| Champ | Valeur |
|---|---|
| Email | `eve.holt@reqres.in` |
| Mot de passe | `cityslicka` |

---

## Installation & Lancement

```bash
# Installer les dépendances
flutter pub get

# Lancer l'application
flutter run
```

---

## Tests

| Type | Fichiers | Nombre |
|---|---|---|
| Unitaires (Repository) | `test/auth_repository_test.dart`, `test/movie_repository_test.dart` | 6 |
| Unitaires (Provider) | `test/unit/movie_provider_test.dart`, `test/unit/auth_provider_test.dart` | 14 |
| Widgets | `test/widget/movie_card_test.dart`, `test/widget/shared_widgets_test.dart` | 11 |
| Intégration | `integration_test/app_test.dart` | 2 |
| **Total** | | **33 tests** |

```bash
# Tous les tests unitaires + widgets
flutter test

# Tests d'intégration (nécessite un device/émulateur)
flutter test integration_test/app_test.dart
```

---

## CI/CD

Chaque push sur `main` déclenche automatiquement :
1. **`flutter analyze`** — Analyse statique (zéro warning)
2. **`flutter test`** — Suite complète de tests unitaires et widgets

Voir [`.github/workflows/ci.yml`](.github/workflows/ci.yml).

---

## Technologies

| Package | Rôle |
|---|---|
| `dio` | Appels HTTP + intercepteurs |
| `sqflite` | Cache local SQLite |
| `go_router` | Navigation + Auth Guard |
| `provider` | Gestion d'état |
| `shared_preferences` | Persistance du token JWT |
| `mocktail` | Tests unitaires avec mocks |
| `flutter_localizations` | i18n FR + EN |

---

## Changelog

Voir [CHANGELOG.md](CHANGELOG.md) pour l'historique complet des versions.
