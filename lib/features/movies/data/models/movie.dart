class Movie {
  final String id;
  final String title;
  final String description;
  final String director;
  final String genre;
  final int year;
  final int duration;
  final double rating;
  final String imageUrl;

  const Movie({
    required this.id,
    required this.title,
    required this.description,
    required this.director,
    required this.genre,
    required this.year,
    required this.duration,
    required this.rating,
    required this.imageUrl,
  });

  factory Movie.fromTMDBJson(Map<String, dynamic> json) {
    // TMDB uses 'poster_path' or 'backdrop_path'
    final poster = json['poster_path'] ?? json['backdrop_path'] ?? '';
    final fullImageUrl = poster.isNotEmpty ? 'https://image.tmdb.org/t/p/w500$poster' : 'https://via.placeholder.com/500x750.png?text=No+Image';
    
    // TMDB genre_ids can be mapped to strings, for simplicity we just say 'TMDB Genre'
    // TMDB release_date format is YYYY-MM-DD
    final releaseDate = json['release_date'] as String? ?? '';
    final year = releaseDate.length >= 4 ? int.tryParse(releaseDate.substring(0, 4)) ?? 2024 : 2024;

    return Movie(
      id: json['id'].toString(),
      title: json['title'] ?? json['original_title'] ?? 'Titre Inconnu',
      description: json['overview'] ?? '',
      director: 'Inconnu', // TMDB requires a separate /credits call for director, simplify here
      genre: 'Film', 
      year: year,
      duration: 120, // TMDB requires a separate /movie/{id} call for runtime, simplify here
      rating: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      imageUrl: fullImageUrl,
    );
  }

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      director: map['director'],
      genre: map['genre'],
      year: map['year'],
      duration: map['duration'],
      rating: map['rating'],
      imageUrl: map['imageUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'director': director,
      'genre': genre,
      'year': year,
      'duration': duration,
      'rating': rating,
      'imageUrl': imageUrl,
    };
  }

  Movie copyWith({
    String? id,
    String? title,
    String? description,
    String? director,
    String? genre,
    int? year,
    int? duration,
    double? rating,
    String? imageUrl,
  }) {
    return Movie(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      director: director ?? this.director,
      genre: genre ?? this.genre,
      year: year ?? this.year,
      duration: duration ?? this.duration,
      rating: rating ?? this.rating,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
