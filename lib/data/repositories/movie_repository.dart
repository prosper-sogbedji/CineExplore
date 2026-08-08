import 'package:flutter/foundation.dart';

import '../models/movie.dart';

class MovieRepository extends ChangeNotifier {
  MovieRepository({List<Movie>? initialMovies})
    : _movies = List<Movie>.from(initialMovies ?? _seedMovies);

  final List<Movie> _movies;

  List<Movie> get movies => List.unmodifiable(_movies);

  bool get isLoading => false;

  List<String> get genres {
    final values = _movies.map((movie) => movie.genre).toSet().toList()..sort();
    return values;
  }

  Movie? findById(String id) {
    for (final movie in _movies) {
      if (movie.id == id) {
        return movie;
      }
    }
    return null;
  }

  List<Movie> searchAndFilter({String query = '', String? genre, int? year}) {
    final normalizedQuery = query.trim().toLowerCase();
    return _movies.where((movie) {
      final matchesQuery =
          normalizedQuery.isEmpty ||
          movie.title.toLowerCase().contains(normalizedQuery) ||
          movie.director.toLowerCase().contains(normalizedQuery);
      final matchesGenre =
          genre == null || genre.isEmpty || movie.genre == genre;
      final matchesYear = year == null || movie.year == year;
      return matchesQuery && matchesGenre && matchesYear;
    }).toList();
  }

  Movie addMovie({
    required String title,
    required String description,
    required String director,
    required String genre,
    required int year,
    int duration = 100,
    double rating = 0,
    String? imageUrl,
  }) {
    final movie = Movie(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      title: title.trim(),
      description: description.trim(),
      director: director.trim(),
      genre: genre.trim(),
      year: year,
      duration: duration,
      rating: rating,
      imageUrl:
          imageUrl ??
          'https://images.unsplash.com/photo-1489599849927-2ee91cede3ba?auto=format&fit=crop&w=900&q=80',
    );
    _movies.insert(0, movie);
    notifyListeners();
    return movie;
  }
}

const List<Movie> _seedMovies = [
  Movie(
    id: '1',
    title: 'Inception',
    description:
        'Un extracteur de secrets infiltre les reves, puis accepte une mission impossible: implanter une idee.',
    director: 'Christopher Nolan',
    genre: 'Science-fiction',
    year: 2010,
    duration: 148,
    rating: 8.8,
    imageUrl:
        'https://images.unsplash.com/photo-1440404653325-ab127d49abc1?auto=format&fit=crop&w=900&q=80',
  ),
  Movie(
    id: '2',
    title: 'Parasite',
    description:
        'Deux familles que tout oppose se croisent dans une satire sociale aussi drole que cruelle.',
    director: 'Bong Joon-ho',
    genre: 'Thriller',
    year: 2019,
    duration: 132,
    rating: 8.5,
    imageUrl:
        'https://images.unsplash.com/photo-1517604931442-7e0c8ed2963c?auto=format&fit=crop&w=900&q=80',
  ),
  Movie(
    id: '3',
    title: 'Interstellar',
    description:
        'Des explorateurs traversent un trou de ver pour chercher un nouvel avenir a l humanite.',
    director: 'Christopher Nolan',
    genre: 'Science-fiction',
    year: 2014,
    duration: 169,
    rating: 8.7,
    imageUrl:
        'https://images.unsplash.com/photo-1462331940025-496dfbfc7564?auto=format&fit=crop&w=900&q=80',
  ),
  Movie(
    id: '4',
    title: 'La La Land',
    description:
        'Une actrice et un pianiste vivent une romance musicale entre ambition, reve et renoncements.',
    director: 'Damien Chazelle',
    genre: 'Musical',
    year: 2016,
    duration: 128,
    rating: 8.0,
    imageUrl:
        'https://images.unsplash.com/photo-1505686994434-e3cc5abf1330?auto=format&fit=crop&w=900&q=80',
  ),
  Movie(
    id: '5',
    title: 'The Grand Budapest Hotel',
    description:
        'Un concierge legendaire et son jeune protege se retrouvent au coeur d une affaire rocambolesque.',
    director: 'Wes Anderson',
    genre: 'Comedie',
    year: 2014,
    duration: 99,
    rating: 8.1,
    imageUrl:
        'https://images.unsplash.com/photo-1524985069026-dd778a71c7b4?auto=format&fit=crop&w=900&q=80',
  ),
  Movie(
    id: '6',
    title: 'Mad Max: Fury Road',
    description:
        'Dans un desert post-apocalyptique, Furiosa et Max fuient un tyran dans une course furieuse.',
    director: 'George Miller',
    genre: 'Action',
    year: 2015,
    duration: 120,
    rating: 8.1,
    imageUrl:
        'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?auto=format&fit=crop&w=900&q=80',
  ),
  Movie(
    id: '7',
    title: 'Arrival',
    description:
        'Une linguiste tente de communiquer avec des visiteurs extraterrestres avant une crise mondiale.',
    director: 'Denis Villeneuve',
    genre: 'Science-fiction',
    year: 2016,
    duration: 116,
    rating: 7.9,
    imageUrl:
        'https://images.unsplash.com/photo-1454789548928-9efd52dc4031?auto=format&fit=crop&w=900&q=80',
  ),
  Movie(
    id: '8',
    title: 'The Social Network',
    description:
        'La naissance d un reseau social mondial revele ambitions, conflits et trahisons.',
    director: 'David Fincher',
    genre: 'Drame',
    year: 2010,
    duration: 120,
    rating: 7.8,
    imageUrl:
        'https://images.unsplash.com/photo-1516321318423-f06f85e504b3?auto=format&fit=crop&w=900&q=80',
  ),
  Movie(
    id: '9',
    title: 'Coco',
    description:
        'Un jeune musicien voyage au pays des morts pour comprendre l histoire de sa famille.',
    director: 'Lee Unkrich',
    genre: 'Animation',
    year: 2017,
    duration: 105,
    rating: 8.4,
    imageUrl:
        'https://images.unsplash.com/photo-1514525253161-7a46d19cd819?auto=format&fit=crop&w=900&q=80',
  ),
  Movie(
    id: '10',
    title: 'The Dark Knight',
    description:
        'Batman affronte le Joker, un adversaire chaotique qui pousse Gotham dans ses limites.',
    director: 'Christopher Nolan',
    genre: 'Action',
    year: 2008,
    duration: 152,
    rating: 9.0,
    imageUrl:
        'https://images.unsplash.com/photo-1509347528160-9a9e33742cdb?auto=format&fit=crop&w=900&q=80',
  ),
  Movie(
    id: '11',
    title: 'Her',
    description:
        'Un homme solitaire tombe amoureux d une intelligence artificielle a la voix troublante.',
    director: 'Spike Jonze',
    genre: 'Romance',
    year: 2013,
    duration: 126,
    rating: 8.0,
    imageUrl:
        'https://images.unsplash.com/photo-1496181133206-80ce9b88a853?auto=format&fit=crop&w=900&q=80',
  ),
  Movie(
    id: '12',
    title: 'Whiplash',
    description:
        'Un batteur de jazz ambitieux subit l enseignement brutal d un professeur obsede par l excellence.',
    director: 'Damien Chazelle',
    genre: 'Drame',
    year: 2014,
    duration: 106,
    rating: 8.5,
    imageUrl:
        'https://images.unsplash.com/photo-1511192336575-5a79af67a629?auto=format&fit=crop&w=900&q=80',
  ),
  Movie(
    id: '13',
    title: 'Spirited Away',
    description:
        'Une fillette prisonniere d un monde magique doit sauver ses parents transformes.',
    director: 'Hayao Miyazaki',
    genre: 'Animation',
    year: 2001,
    duration: 125,
    rating: 8.6,
    imageUrl:
        'https://images.unsplash.com/photo-1578632767115-351597cf2477?auto=format&fit=crop&w=900&q=80',
  ),
  Movie(
    id: '14',
    title: 'Knives Out',
    description:
        'Un detective demonte les mensonges d une famille apres la mort suspecte d un auteur celebre.',
    director: 'Rian Johnson',
    genre: 'Mystere',
    year: 2019,
    duration: 130,
    rating: 7.9,
    imageUrl:
        'https://images.unsplash.com/photo-1502161254066-6c74afbf07aa?auto=format&fit=crop&w=900&q=80',
  ),
  Movie(
    id: '15',
    title: 'Dune',
    description:
        'Paul Atreides decouvre Arrakis, planete desertique au coeur d enjeux politiques et mystiques.',
    director: 'Denis Villeneuve',
    genre: 'Science-fiction',
    year: 2021,
    duration: 155,
    rating: 8.0,
    imageUrl:
        'https://images.unsplash.com/photo-1500534314209-a25ddb2bd429?auto=format&fit=crop&w=900&q=80',
  ),
];
