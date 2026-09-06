import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;
  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  bool get isFr => locale.languageCode == 'fr';

  // Auth
  String get login => isFr ? 'Connexion' : 'Login';
  String get register => isFr ? 'Inscription' : 'Register';
  String get logout => isFr ? 'Se déconnecter' : 'Logout';
  String get email => 'Email';
  String get password => isFr ? 'Mot de passe' : 'Password';
  String get connect => isFr ? 'Se connecter' : 'Sign In';
  String get createAccount => isFr ? 'Créer un compte' : 'Create account';
  String get alreadyAccount => isFr ? 'Déjà un compte ? Connectez-vous' : 'Already have an account? Sign in';
  String get signUp => isFr ? "S'inscrire" : 'Sign Up';

  // Navigation
  String get home => isFr ? 'Accueil' : 'Home';
  String get search => isFr ? 'Recherche' : 'Search';
  String get profile => isFr ? 'Profil' : 'Profile';

  // Movies
  String get trending => isFr ? 'Films Tendances' : 'Trending Movies';
  String get noResults => isFr ? 'Aucun résultat' : 'No results';
  String get searchMovies => isFr ? 'Rechercher un film...' : 'Search a movie...';
  String get noMoviesFound => isFr ? 'Aucun film trouvé pour cette recherche.' : 'No movies found for this search.';
  String get synopsis => isFr ? 'Synopsis' : 'Synopsis';
  String get director => isFr ? 'Réalisateur' : 'Director';
  String get movieNotFound => isFr ? 'Film introuvable' : 'Movie not found';

  // Settings
  String get settings => isFr ? 'Profil & Paramètres' : 'Profile & Settings';
  String get darkMode => isFr ? 'Mode Sombre' : 'Dark Mode';
  String get darkModeDesc => isFr ? 'Activer le thème sombre' : 'Enable dark theme';
  String get connectedUser => isFr ? 'Utilisateur Connecté' : 'Connected User';
  String get connectedViaJwt => isFr ? 'Connecté via Token JWT' : 'Connected via JWT Token';

  // Errors
  String get networkError => isFr ? 'Mode hors-ligne' : 'Offline mode';
  String get loading => isFr ? 'Chargement...' : 'Loading...';
  String get error => isFr ? 'Erreur' : 'Error';
  String get routeNotFound => isFr ? 'Route introuvable' : 'Route not found';
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      ['fr', 'en'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async =>
      AppLocalizations(locale);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
