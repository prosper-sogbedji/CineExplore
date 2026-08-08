import 'package:flutter/material.dart';

import '../data/repositories/movie_repository.dart';
import '../widgets/empty_state.dart';
import '../widgets/genre_filter.dart';
import '../widgets/movie_grid.dart';
import '../widgets/movie_search_field.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.repository});

  final MovieRepository repository;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchController = TextEditingController();
  String _query = '';
  String? _genre;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _resetFilters() {
    setState(() {
      _query = '';
      _genre = null;
      _searchController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final movies = widget.repository.searchAndFilter(
      query: _query,
      genre: _genre,
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('CineExplore'),
        actions: [
          IconButton(
            tooltip: 'Reinitialiser les filtres',
            icon: const Icon(Icons.refresh),
            onPressed: _resetFilters,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth >= 640;
                final search = MovieSearchField(
                  controller: _searchController,
                  onChanged: (value) => setState(() => _query = value),
                );
                final filter = GenreFilter(
                  genres: widget.repository.genres,
                  selectedGenre: _genre,
                  onChanged: (value) => setState(() => _genre = value),
                );
                if (isWide) {
                  return Row(
                    children: [
                      Expanded(flex: 2, child: search),
                      const SizedBox(width: 12),
                      Expanded(child: filter),
                    ],
                  );
                }
                return Column(
                  children: [search, const SizedBox(height: 12), filter],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: Row(
              children: [
                Text(
                  '${movies.length} film(s) trouve(s)',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const Spacer(),
                TextButton.icon(
                  onPressed: _resetFilters,
                  icon: const Icon(Icons.tune),
                  label: const Text('Reset'),
                ),
              ],
            ),
          ),
          Expanded(
            child: widget.repository.isLoading
                ? const Center(child: CircularProgressIndicator())
                : movies.isEmpty
                ? const EmptyState(
                    icon: Icons.movie_filter_outlined,
                    title: 'Aucun resultat',
                    message: 'Aucun film ne correspond a votre recherche.',
                  )
                : MovieGrid(movies: movies),
          ),
        ],
      ),
    );
  }
}
