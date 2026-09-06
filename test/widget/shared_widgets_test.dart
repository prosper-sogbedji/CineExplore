import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cine_explore/shared/widgets/rating_badge.dart';
import 'package:cine_explore/shared/widgets/empty_state.dart';

void main() {
  group('RatingBadge Widget Tests', () {
    testWidgets('affiche la note formatée', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: RatingBadge(rating: 8.5)),
        ),
      );

      expect(find.text('8.5'), findsOneWidget);
    });

    testWidgets('affiche une icône étoile', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: RatingBadge(rating: 7.0)),
        ),
      );

      expect(find.byIcon(Icons.star_rounded), findsOneWidget);
    });

    testWidgets('note entière affiche .0', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: RatingBadge(rating: 9.0)),
        ),
      );

      expect(find.text('9.0'), findsOneWidget);
    });
  });

  group('EmptyState Widget Tests', () {
    testWidgets('affiche le titre et le message', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: EmptyState(
              icon: Icons.search_off,
              title: 'Aucun résultat',
              message: 'Aucun film trouvé',
            ),
          ),
        ),
      );

      expect(find.text('Aucun résultat'), findsOneWidget);
      expect(find.text('Aucun film trouvé'), findsOneWidget);
    });

    testWidgets('affiche l\'icône correcte', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: EmptyState(
              icon: Icons.error_outline,
              title: 'Erreur',
              message: 'Une erreur est survenue',
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.error_outline), findsOneWidget);
    });

    testWidgets('affiche l\'action si fournie', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EmptyState(
              icon: Icons.refresh,
              title: 'Rafraîchir',
              message: 'Appuyez pour réessayer',
              action: ElevatedButton(
                onPressed: () {},
                child: const Text('Réessayer'),
              ),
            ),
          ),
        ),
      );

      expect(find.text('Réessayer'), findsOneWidget);
    });
  });
}
