import 'package:dio/dio.dart';
import '../../../../core/network/api_constants.dart';
import '../../../../core/network/dio_client.dart';
import '../models/movie.dart';
import '../daos/movie_dao.dart';

class MovieRepository {
  final Dio _dio;
  final MovieDao _movieDao;

  MovieRepository({Dio? dio, MovieDao? movieDao}) 
      : _dio = dio ?? DioClient().dio,
        _movieDao = movieDao ?? MovieDao();

  Future<List<Movie>> getTrendingMovies() async {
    try {
      final response = await _dio.get('${ApiConstants.tmdbBaseUrl}/trending/movie/week');
      final List results = response.data['results'];
      final movies = results.map((e) => Movie.fromTMDBJson(e)).toList();
      
      // Mettre en cache les films
      await _movieDao.cacheMovies(movies);
      
      return movies;
    } catch (e) {
      // En cas d'erreur (ex: hors ligne), retourner le cache
      final cachedMovies = await _movieDao.getCachedMovies();
      if (cachedMovies.isNotEmpty) {
        return cachedMovies;
      }
      throw Exception('Erreur réseau et aucun cache disponible.');
    }
  }

  Future<List<Movie>> searchMovies(String query) async {
    if (query.isEmpty) return [];
    try {
      final response = await _dio.get('${ApiConstants.tmdbBaseUrl}/search/movie', queryParameters: {
        'query': query,
      });
      final List results = response.data['results'];
      return results.map((e) => Movie.fromTMDBJson(e)).toList();
    } catch (e) {
      throw Exception('Erreur lors de la recherche.');
    }
  }

  Future<Movie> getMovieDetails(String id) async {
    try {
      final response = await _dio.get('${ApiConstants.tmdbBaseUrl}/movie/$id');
      return Movie.fromTMDBJson(response.data);
    } catch (e) {
      // Si on est hors ligne, on cherche dans le cache
      final cachedMovies = await _movieDao.getCachedMovies();
      final movie = cachedMovies.where((m) => m.id == id).firstOrNull;
      if (movie != null) {
        return movie;
      }
      throw Exception('Film introuvable.');
    }
  }
}
