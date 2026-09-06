import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';
import 'package:cine_explore/features/movies/data/repositories/movie_repository.dart';
import 'package:cine_explore/features/movies/data/daos/movie_dao.dart';
import 'package:cine_explore/features/movies/data/models/movie.dart';

class MockDio extends Mock implements Dio {}
class MockMovieDao extends Mock implements MovieDao {}

void main() {
  late MovieRepository repository;
  late MockDio mockDio;
  late MockMovieDao mockMovieDao;

  setUp(() {
    mockDio = MockDio();
    mockMovieDao = MockMovieDao();
    repository = MovieRepository(dio: mockDio, movieDao: mockMovieDao);
  });

  group('MovieRepository Tests', () {
    test('getTrendingMovies retourne une liste de films depuis API et met en cache', () async {
      // Arrange
      final mockResponse = {
        'results': [
          {'id': 1, 'title': 'Test Movie', 'overview': 'Desc', 'release_date': '2024-01-01'}
        ]
      };
      
      when(() => mockDio.get(any(), queryParameters: any(named: 'queryParameters')))
          .thenAnswer((_) async => Response(
                data: mockResponse,
                statusCode: 200,
                requestOptions: RequestOptions(path: ''),
              ));
              
      when(() => mockMovieDao.cacheMovies(any())).thenAnswer((_) async => {});

      // Act
      final movies = await repository.getTrendingMovies();

      // Assert
      expect(movies.length, 1);
      expect(movies.first.title, 'Test Movie');
      verify(() => mockMovieDao.cacheMovies(any())).called(1);
    });

    test('getTrendingMovies retourne le cache en cas d\\'erreur réseau', () async {
      // Arrange
      when(() => mockDio.get(any(), queryParameters: any(named: 'queryParameters')))
          .thenThrow(DioException(requestOptions: RequestOptions(path: '')));
          
      final cachedMovies = [
        const Movie(id: '1', title: 'Cached Movie', description: '', director: '', genre: '', year: 2024, duration: 120, rating: 5, imageUrl: '')
      ];
      
      when(() => mockMovieDao.getCachedMovies()).thenAnswer((_) async => cachedMovies);

      // Act
      final movies = await repository.getTrendingMovies();

      // Assert
      expect(movies.length, 1);
      expect(movies.first.title, 'Cached Movie');
      verify(() => mockMovieDao.getCachedMovies()).called(1);
    });

    test('searchMovies retourne une liste de films correspondant à la requête', () async {
      // Arrange
      final mockResponse = {
        'results': [
          {'id': 2, 'title': 'Inception', 'overview': 'Dream', 'release_date': '2010-01-01'}
        ]
      };
      
      when(() => mockDio.get(any(), queryParameters: any(named: 'queryParameters')))
          .thenAnswer((_) async => Response(
                data: mockResponse,
                statusCode: 200,
                requestOptions: RequestOptions(path: ''),
              ));

      // Act
      final movies = await repository.searchMovies('Inception');

      // Assert
      expect(movies.length, 1);
      expect(movies.first.title, 'Inception');
    });
  });
}
