import 'package:sqflite/sqflite.dart';
import '../../../../core/database/database_helper.dart';
import '../models/movie.dart';

class MovieDao {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<void> cacheMovies(List<Movie> movies) async {
    final db = await _dbHelper.database;
    final batch = db.batch();
    
    // Clear old cache for simplicity in this project
    batch.delete('movies');

    for (var movie in movies) {
      batch.insert('movies', movie.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    }
    
    await batch.commit(noResult: true);
  }

  Future<List<Movie>> getCachedMovies() async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('movies');
    
    return List.generate(maps.length, (i) {
      return Movie.fromMap(maps[i]);
    });
  }
}
