import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/repositories/movie_repository.dart';
import '../screens/add_movie_screen.dart';
import '../screens/home_screen.dart';
import '../screens/movie_detail_screen.dart';
import '../screens/movies_screen.dart';
import '../screens/settings_screen.dart';
import '../state/theme_controller.dart';
import '../widgets/app_scaffold.dart';

GoRouter createAppRouter({
  required MovieRepository repository,
  required ThemeController themeController,
}) {
  return GoRouter(
    initialLocation: '/home',
    redirect: (context, state) => state.uri.path == '/' ? '/home' : null,
    routes: [
      ShellRoute(
        builder: (context, state, child) => AppScaffold(child: child),
        routes: [
          GoRoute(
            path: '/home',
            pageBuilder: (context, state) =>
                NoTransitionPage(child: HomeScreen(repository: repository)),
          ),
          GoRoute(
            path: '/movies',
            pageBuilder: (context, state) =>
                NoTransitionPage(child: MoviesScreen(repository: repository)),
          ),
          GoRoute(
            path: '/movie/:id',
            builder: (context, state) => MovieDetailScreen(
              repository: repository,
              movieId: state.pathParameters['id'] ?? '',
            ),
          ),
          GoRoute(
            path: '/add-movie',
            pageBuilder: (context, state) =>
                NoTransitionPage(child: AddMovieScreen(repository: repository)),
          ),
          GoRoute(
            path: '/settings',
            pageBuilder: (context, state) => NoTransitionPage(
              child: SettingsScreen(themeController: themeController),
            ),
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(title: const Text('Erreur')),
      body: Center(child: Text('Route introuvable: ${state.uri}')),
    ),
  );
}
