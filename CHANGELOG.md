# Changelog

All notable changes to CineExplore are documented here.
Format follows [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

---

## [1.2.0] - 2026-09-06

### Added — Production-Ready

- **CI/CD** : Pipeline GitHub Actions (`flutter analyze` + `flutter test`) sur chaque push/PR vers `main`
- **Internationalisation (i18n)** : Support complet FR 🇫🇷 et EN 🇬🇧 via `AppLocalizations`
- **Accessibilité (a11y)** : Ajout de `Semantics` labels sur tous les éléments interactifs (MovieCard, boutons de navigation, champs de formulaire)
- **Tests — Unitaires** : 14 tests unitaires au total (MovieProvider ×8, AuthProvider ×6)
- **Tests — Widgets** : 11 tests de widgets (MovieCard ×5, RatingBadge ×3, EmptyState ×3)
- **Tests — Intégration** : 2 tests d'intégration (démarrage de l'app, navigation)
- **Performance** : Lazy loading des images avec `loadingBuilder` dans `MovieCard`
- **Performance** : Ajout de `const` sur tous les widgets statiques pour éviter les rebuilds inutiles

### Changed

- `LoginScreen` / `RegisterScreen` : ajout de `const` constructeur + protection `mounted` avant navigation
- `SettingsScreen` : `UserAccountsDrawerHeader` rendu `const`
- `MovieProvider` / `AuthProvider` : ajout de constructeur nommé `.withRepository()` pour l'injection de dépendances dans les tests
- `pubspec.yaml` : version `1.2.0+3`

### Fixed

- Correction de 8 warnings `flutter analyze` (imports manquants, literaux d'apostrophe, `mounted` non vérifié)

---

## [1.1.0] - 2026-09-06

### Added — Full-Stack

- **API TMDB** : Récupération des films tendances, recherche et détail via `Dio`
- **Authentification JWT** : Login et register via `ReqRes.in` avec persistance du token (`shared_preferences`)
- **Cache local** : Sauvegarde automatique des films avec `sqflite` (`MovieDao`, `DatabaseHelper`)
- **Mode Hors-ligne** : Fallback sur le cache SQLite si l'API est inaccessible
- **Intercepteur Dio** : `AuthInterceptor` injecte automatiquement le token JWT et la clé API TMDB
- **Architecture Clean (Feature-First)** : Réorganisation complète du code en `core`, `features/auth`, `features/movies`, `shared`
- **GoRouter avec Auth Guard** : Redirection automatique vers `/login` si non authentifié
- **Tests unitaires** : 6 tests sur `MovieRepository` et `AuthRepository` avec `mocktail`

### Changed

- Migration de `MovieRepository` en-ligne vers TMDB
- Mise à jour du `README.md` avec les nouvelles instructions de configuration

---

## [1.0.0] - 2026-08-08

### Added — MVP Initial

- Application Flutter avec architecture en couches
- 4 écrans : Accueil, Recherche, Détail, Paramètres
- Base de données SQLite locale pour stocker des films ajoutés manuellement
- Thème clair / sombre avec `ThemeController`
- Navigation avec `GoRouter` et `NavigationBar`
- Recherche et filtre par genre sur les films
- `MovieCard` avec note et image
