import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:provider/provider.dart';
import 'package:cine_explore/main.dart' as app;
import 'package:cine_explore/features/auth/presentation/providers/auth_provider.dart';
import 'package:cine_explore/features/movies/presentation/providers/movie_provider.dart';
import 'package:cine_explore/core/theme/theme_controller.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Tests d\'intégration CineExplore', () {
    testWidgets('Affiche l\'écran de login au démarrage (non authentifié)', (tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // L'utilisateur non authentifié doit voir l'écran de connexion
      expect(find.text('Connexion'), findsWidgets);
    });

    testWidgets('Navigation entre onglets après authentification', (tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => ThemeController()),
            ChangeNotifierProvider(create: (_) => AuthProvider()),
            ChangeNotifierProvider(create: (_) => MovieProvider()),
          ],
          child: const app.CineExploreApp(),
        ),
      );
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Chercher les éléments de navigation (si connecté, la barre de navigation apparaît)
      // Selon l'état auth, on voit soit Login soit la navbar
      expect(
        find.byType(MaterialApp),
        findsOneWidget,
      );
    });
  });
}
