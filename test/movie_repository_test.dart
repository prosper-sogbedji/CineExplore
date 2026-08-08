import 'package:cine_explore/data/models/movie.dart';
import 'package:cine_explore/data/repositories/movie_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late MovieRepository repository;

  setUp(() {
    repository = MovieRepository(
      initialMovies: const [
        Movie(
          id: 'a',
          title: 'Moon Signal',
          description: 'A quiet signal from space.',
          director: 'Nia Stone',
          genre: 'Science-fiction',
          year: 2020,
          duration: 101,
          rating: 7.4,
          imageUrl: 'https://example.com/moon.jpg',
        ),
        Movie(
          id: 'b',
          title: 'City Laughs',
          description: 'A warm urban comedy.',
          director: 'Leo March',
          genre: 'Comedie',
          year: 2021,
          duration: 94,
          rating: 6.8,
          imageUrl: 'https://example.com/city.jpg',
        ),
      ],
    );
  });

  test('recherche par titre', () {
    final results = repository.searchAndFilter(query: 'moon');

    expect(results, hasLength(1));
    expect(results.single.id, 'a');
  });

  test('recherche par realisateur', () {
    final results = repository.searchAndFilter(query: 'march');

    expect(results, hasLength(1));
    expect(results.single.title, 'City Laughs');
  });

  test('filtrage par genre et annee', () {
    final results = repository.searchAndFilter(genre: 'Comedie', year: 2021);

    expect(results, hasLength(1));
    expect(results.single.id, 'b');
  });

  test('recuperation par ID existant', () {
    expect(repository.findById('a')?.title, 'Moon Signal');
  });

  test('retourne null pour un ID inexistant', () {
    expect(repository.findById('missing'), isNull);
  });

  test('ajoute un film dans le repository', () {
    repository.addMovie(
      title: 'New Frame',
      description: 'A new movie.',
      director: 'Ava Reed',
      genre: 'Drame',
      year: 2024,
    );

    expect(repository.movies.first.title, 'New Frame');
    expect(repository.movies, hasLength(3));
  });
}
