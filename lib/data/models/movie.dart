class Movie {
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

  final String id;
  final String title;
  final String description;
  final String director;
  final String genre;
  final int year;
  final int duration;
  final double rating;
  final String imageUrl;

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
