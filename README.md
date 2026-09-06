# CineExplore Full-Stack

CineExplore a été mis à niveau vers une application Flutter full-stack pour valider la maîtrise des APIs, de l'architecture et de la persistance des données. 

## Fonctionnalités

- **Authentification (JWT)** : Système de connexion et d'inscription avec stockage sécurisé du token.
- **Catalogue Connecté** : Intégration avec **TMDB (The Movie Database)** pour récupérer les films tendances, rechercher des films, et afficher les détails.
- **Cache Local & Hors-ligne** : Les films récupérés sont sauvegardés via **SQLite**. En cas de perte réseau, l'application bascule automatiquement sur le cache local.
- **Gestion des Erreurs** : Interception des erreurs réseau avec feedbacks utilisateurs clairs.
- **Architecture Clean / Feature-First** : Code organisé par fonctionnalités (Auth, Movies) avec séparation stricte des couches (Data, Domain, Presentation).

## Technologies

- **Flutter** & **Dart**
- **Dio** : Appels réseau et intercepteurs (injection de token et fallback hors-ligne).
- **SQLite (`sqflite`)** : Persistance des données relationnelles en local.
- **Provider** : Gestion de l'état simple et réactive.
- **GoRouter** : Navigation avec redirections basées sur l'état de l'authentification (Auth Guard).
- **Mocktail** : Tests unitaires.

## Architecture (Feature-First)

```text
lib/
├── core/
│   ├── database/       (Configuration SQLite, DatabaseHelper)
│   ├── network/        (DioClient, AuthInterceptor, ApiConstants)
│   ├── router/         (GoRouter, Auth Guard)
│   └── theme/          (ThemeController)
├── features/
│   ├── auth/
│   │   ├── data/       (Models, AuthRepository)
│   │   └── presentation/ (LoginScreen, RegisterScreen, AuthProvider)
│   └── movies/
│       ├── data/       (Models, MovieRepository, MovieDao)
│       └── presentation/ (HomeScreen, MoviesScreen, DetailScreen, MovieProvider)
└── shared/
    └── widgets/        (Composants réutilisables)
```

## Configuration du Projet (IMPORTANT)

Pour utiliser ce projet, vous devez fournir votre propre clé d'API TMDB :

1. Ouvrez le fichier `lib/core/network/api_constants.dart`.
2. Remplacez la valeur de `tmdbApiKey` par votre clé (ex: `static const String tmdbApiKey = 'VOTRE_CLE';`).

L'authentification utilise l'API publique de test **ReqRes.in** pour simuler un vrai JWT backend (login/register). 
- *Email de test* : `eve.holt@reqres.in`
- *Mot de passe* : (n'importe lequel, ex: `cityslicka`)

## Installation

```bash
flutter pub get
flutter run
```

## Tests

Plusieurs tests unitaires stricts ont été implémentés pour valider la logique d'accès aux données (Repository pattern).

```bash
flutter test
```

## Captures d'écran

(À rajouter par l'utilisateur une fois l'application lancée avec succès).
