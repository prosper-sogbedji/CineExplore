import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cine_explore/shared/widgets/movie_card.dart';
import 'package:cine_explore/features/movies/data/models/movie.dart';

const testMovie = Movie(
  id: '42',
  title: 'The Dark Knight',
  description: 'Batman fights the Joker',
  director: 'Christopher Nolan',
  genre: 'Action',
  year: 2008,
  duration: 152,
  rating: 9.0,
  imageUrl: '',
);

Widget buildTestCard({VoidCallback? onTap}) {
  return MaterialApp(
    home: Scaffold(
      body: SizedBox(
        height: 300,
        child: MovieCard(
          movie: testMovie,
          onTap: onTap ?? () {},
        ),
      ),
    ),
  );
}

void main() {
  group('MovieCard Widget Tests', () {
    testWidgets('affiche le titre du film', (tester) async {
      await tester.pumpWidget(buildTestCard());

      expect(find.text('The Dark Knight'), findsOneWidget);
    });

    testWidgets('affiche l\'année du film', (tester) async {
      await tester.pumpWidget(buildTestCard());

      expect(find.text('2008'), findsOneWidget);
    });

    testWidgets('affiche le genre du film', (tester) async {
      await tester.pumpWidget(buildTestCard());

      expect(find.text('Action'), findsOneWidget);
    });

    testWidgets('appelle onTap au clic', (tester) async {
      var tapped = false;
      await tester.pumpWidget(buildTestCard(onTap: () => tapped = true));

      await tester.tap(find.byType(InkWell));

      expect(tapped, true);
    });

    testWidgets('a un Semantics label correct', (tester) async {
      await tester.pumpWidget(buildTestCard());

      final semantics = find.bySemanticsLabel(
        RegExp('The Dark Knight'),
      );
      expect(semantics, findsWidgets);
    });
  });
}
