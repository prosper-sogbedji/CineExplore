# CineExplore

CineExplore est une application Flutter de découverte de films construite pour démontrer l'utilisation de GoRouter et de ChangeNotifier pour la gestion d'état. Le projet charge une liste locale de films, génère un catalogue complet, et propose des recherches, des filtres, des détails de film, un formulaire d'ajout et des états d'interface utilisateur explicites.

## Fonctionnalités

- Catalogue de films sous forme de cartes avec affiche, titre, année, genre et note.
- Détail complet transmis via route `/movie/:id` avec gestion de film introuvable.
- Recherche par titre ou réalisateur.
- Filtrage par genre et par année.
- Formulaire d'ajout avec validations et feedback utilisateur.
- Écran profil/paramètres avec informations utilisateur mockées.
- États de chargement, aucun résultat et erreur.
- Thème clair/sombre Material 3 et navigation par `NavigationBar`.

## Technologies

- Flutter
- Dart
- GoRouter
- ChangeNotifier
- Liste locale
- Material 3

## Architecture

```text
Presentation
   ↓
Router
   ↓
Controllers
   ↓
Repositories
   ↓
Local List
```

Structure principale :

```text
lib/
├── data/
│   ├── models/
│   └── repositories/
├── router/
├── screens/
├── state/
├── theme/
└── widgets/
```

## Fournisseurs

| Fournisseur | Responsabilité |
|---|---|
| `MovieRepository` | Fournit le référentiel des films, la recherche et le filtrage |
| `ThemeController` | Gère le thème clair/sombre |

## Installation

```bash
flutter pub get
flutter run
```

## Tests

```bash
flutter test
```

Les tests couvrent la recherche, le filtrage, la récupération par ID, le comportement avec ID inexistant, l'ajout d'un film et les validations principales du formulaire.

## Captures d'écran

Section prévue pour ajouter les captures d'écran du catalogue, du détail de film, du formulaire et du mode sombre.
