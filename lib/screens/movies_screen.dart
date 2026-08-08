import 'package:flutter/material.dart';

import '../data/repositories/movie_repository.dart';
import '../widgets/empty_state.dart';
import '../widgets/genre_filter.dart';
import '../widgets/movie_grid.dart';
import '../widgets/movie_search_field.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({super.key, required this.repository});

  final MovieRepository repository;

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  final _searchController = TextEditingController();
  final _yearController = TextEditingController();
  String _query = '';
  String? _genre;
  int? _year;

  @override
  void dispose() {
    _searchController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  void _reset() {
    setState(() {
      _query = '';
      _genre = null;
      _year = null;
      _searchController.clear();
      _yearController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final movies = widget.repository.searchAndFilter(
      query: _query,
      genre: _genre,
      year: _year,
    );
    return Scaffold(
      appBar: AppBar(title: const Text('Recherche de films')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final controls = [
                  MovieSearchField(
                    controller: _searchController,
                    onChanged: (value) => setState(() => _query = value),
                  ),
                  GenreFilter(
                    genres: widget.repository.genres,
                    selectedGenre: _genre,
                    onChanged: (value) => setState(() => _genre = value),
                  ),
                  TextField(
                    controller: _yearController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Annee',
                      prefixIcon: Icon(Icons.event_outlined),
                    ),
                    onChanged: (value) {
                      setState(() => _year = int.tryParse(value));
                    },
                  ),
                ];
                if (constraints.maxWidth >= 820) {
                  return Row(
                    children: [
                      Expanded(flex: 2, child: controls[0]),
                      const SizedBox(width: 12),
                      Expanded(child: controls[1]),
                      const SizedBox(width: 12),
                      Expanded(child: controls[2]),
                    ],
                  );
                }
                return Column(
                  children: [
                    controls[0],
                    const SizedBox(height: 12),
                    controls[1],
                    const SizedBox(height: 12),
                    controls[2],
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Text('${movies.length} resultat(s)'),
                const Spacer(),
                OutlinedButton.icon(
                  onPressed: _reset,
                  icon: const Icon(Icons.clear_all),
                  label: const Text('Effacer'),
                ),
              ],
            ),
          ),
          Expanded(
            child: movies.isEmpty
                ? const EmptyState(
                    icon: Icons.search_off,
                    title: 'Aucun film trouve',
                    message:
                        'Essayez un autre titre, realisateur, genre ou annee.',
                  )
                : MovieGrid(movies: movies),
          ),
        ],
      ),
    );
  }
}
