import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../features/auth/presentation/providers/auth_provider.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/auth/presentation/screens/settings_screen.dart';
import '../../features/movies/presentation/screens/home_screen.dart';
import '../../features/movies/presentation/screens/movie_detail_screen.dart';
import '../../features/movies/presentation/screens/movies_screen.dart';
import '../../shared/widgets/app_scaffold.dart';

GoRouter createAppRouter() {
  return GoRouter(
    initialLocation: '/home',
    redirect: (context, state) {
      final auth = context.read<AuthProvider>();
      final isAuth = auth.isAuthenticated;
      final isGoingToLogin = state.uri.path == '/login';
      final isGoingToRegister = state.uri.path == '/register';

      if (!isAuth && !isGoingToLogin && !isGoingToRegister) {
        return '/login';
      }
      
      if (isAuth && (isGoingToLogin || isGoingToRegister)) {
        return '/home';
      }
      
      if (state.uri.path == '/') return '/home';

      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) => AppScaffold(child: child),
        routes: [
          GoRoute(
            path: '/home',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: HomeScreen()),
          ),
          GoRoute(
            path: '/movies',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: MoviesScreen()),
          ),
          GoRoute(
            path: '/movie/:id',
            builder: (context, state) => MovieDetailScreen(
              id: state.pathParameters['id'] ?? '',
            ),
          ),
          GoRoute(
            path: '/settings',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: SettingsScreen(),
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
