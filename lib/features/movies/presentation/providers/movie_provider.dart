import 'package:flutter/material.dart';
import '../data/repositories/movie_repository.dart';
import '../data/models/movie.dart';

class MovieProvider extends ChangeNotifier {
  final MovieRepository _repository = MovieRepository();

  List<Movie> _trendingMovies = [];
  List<Movie> get trendingMovies => _trendingMovies;

  List<Movie> _searchResults = [];
  List<Movie> get searchResults => _searchResults;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool _isOfflineFallback = false;
  bool get isOfflineFallback => _isOfflineFallback;

  Future<void> fetchTrendingMovies() async {
    _setLoading(true);
    _isOfflineFallback = false;
    try {
      _trendingMovies = await _repository.getTrendingMovies();
      _errorMessage = null;
    } catch (e) {
      if (e.toString().contains('réseau')) {
        _isOfflineFallback = true;
      }
      _errorMessage = e.toString().replaceAll('Exception: ', '');
    }
    _setLoading(false);
  }

  Future<void> searchMovies(String query) async {
    _setLoading(true);
    try {
      _searchResults = await _repository.searchMovies(query);
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
    }
    _setLoading(false);
  }
  
  void clearSearch() {
    _searchResults = [];
    notifyListeners();
  }

  Future<Movie?> getMovieDetails(String id) async {
    _setLoading(true);
    try {
      final movie = await _repository.getMovieDetails(id);
      _errorMessage = null;
      _setLoading(false);
      return movie;
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _setLoading(false);
      return null;
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
