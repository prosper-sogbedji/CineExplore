import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:cine_explore/features/movies/presentation/providers/movie_provider.dart';
import 'package:cine_explore/features/movies/data/repositories/movie_repository.dart';
import 'package:cine_explore/features/movies/data/models/movie.dart';

class MockMovieRepository extends Mock implements MovieRepository {}

const testMovie = Movie(
  id: '1',
  title: 'Inception',
  description: 'A thief who steals corporate secrets',
  director: 'Christopher Nolan',
  genre: 'Science-Fiction',
  year: 2010,
  duration: 148,
  rating: 8.8,
  imageUrl: 'https://example.com/inception.jpg',
);

void main() {
  late MovieProvider provider;
  late MockMovieRepository mockRepository;

  setUp(() {
    mockRepository = MockMovieRepository();
    provider = MovieProvider.withRepository(mockRepository);
  });

  group('MovieProvider - état initial', () {
    test('trendingMovies est vide au démarrage', () {
      expect(provider.trendingMovies, isEmpty);
    });

    test('searchResults est vide au démarrage', () {
      expect(provider.searchResults, isEmpty);
    });

    test('isLoading est false au démarrage', () {
      expect(provider.isLoading, false);
    });

    test('errorMessage est null au démarrage', () {
      expect(provider.errorMessage, isNull);
    });
  });

  group('MovieProvider - fetchTrendingMovies', () {
    test('charge les films avec succès', () async {
      when(() => mockRepository.getTrendingMovies())
          .thenAnswer((_) async => [testMovie]);

      await provider.fetchTrendingMovies();

      expect(provider.trendingMovies.length, 1);
      expect(provider.trendingMovies.first.title, 'Inception');
      expect(provider.errorMessage, isNull);
    });

    test('définit errorMessage en cas d\'erreur réseau', () async {
      when(() => mockRepository.getTrendingMovies())
          .thenThrow(Exception('Erreur réseau'));

      await provider.fetchTrendingMovies();

      expect(provider.trendingMovies, isEmpty);
      expect(provider.errorMessage, isNotNull);
    });
  });

  group('MovieProvider - searchMovies', () {
    test('remplit searchResults avec les résultats', () async {
      when(() => mockRepository.searchMovies(any()))
          .thenAnswer((_) async => [testMovie]);

      await provider.searchMovies('Inception');

      expect(provider.searchResults.length, 1);
      expect(provider.searchResults.first.title, 'Inception');
    });
  });

  group('MovieProvider - clearSearch', () {
    test('vide searchResults', () async {
      when(() => mockRepository.searchMovies(any()))
          .thenAnswer((_) async => [testMovie]);
      await provider.searchMovies('Inception');

      provider.clearSearch();

      expect(provider.searchResults, isEmpty);
    });
  });
}
