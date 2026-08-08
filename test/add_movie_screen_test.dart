import 'package:cine_explore/data/repositories/movie_repository.dart';
import 'package:cine_explore/screens/add_movie_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('affiche les erreurs de validation du formulaire', (
    tester,
  ) async {
    final repository = MovieRepository(initialMovies: const []);

    await tester.pumpWidget(
      MaterialApp(home: AddMovieScreen(repository: repository)),
    );

    await tester.ensureVisible(find.byKey(const Key('submitMovieButton')));
    await tester.tap(find.byKey(const Key('submitMovieButton')));
    await tester.pump();

    expect(find.text('Ce champ est obligatoire'), findsAtLeastNWidgets(4));
  });

  testWidgets('valide que l annee est numerique', (tester) async {
    final repository = MovieRepository(initialMovies: const []);

    await tester.pumpWidget(
      MaterialApp(home: AddMovieScreen(repository: repository)),
    );

    await tester.enterText(find.byKey(const Key('titleField')), 'Film test');
    await tester.enterText(find.byKey(const Key('yearField')), 'abcd');
    await tester.enterText(find.byKey(const Key('directorField')), 'Moi');
    await tester.enterText(find.byKey(const Key('genreField')), 'Drame');
    await tester.enterText(
      find.byKey(const Key('descriptionField')),
      'Description suffisante.',
    );
    await tester.ensureVisible(find.byKey(const Key('submitMovieButton')));
    await tester.tap(find.byKey(const Key('submitMovieButton')));
    await tester.pump();

    expect(find.text('L annee doit etre numerique'), findsOneWidget);
    expect(repository.movies, isEmpty);
  });
}
