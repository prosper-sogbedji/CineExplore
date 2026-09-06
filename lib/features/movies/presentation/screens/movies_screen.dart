import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../shared/widgets/empty_state.dart';
import '../../../../shared/widgets/movie_grid.dart';
import '../../../../shared/widgets/movie_search_field.dart';
import '../providers/movie_provider.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({super.key});

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearch(String query) {
    if (query.isNotEmpty) {
      context.read<MovieProvider>().searchMovies(query);
    } else {
      context.read<MovieProvider>().clearSearch();
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MovieProvider>();
    final movies = provider.searchResults;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Recherche (TMDB)'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: MovieSearchField(
              controller: _searchController,
              onChanged: _onSearch,
            ),
          ),
          Expanded(
            child: provider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : provider.errorMessage != null
                    ? Center(
                        child: Text(
                          provider.errorMessage!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      )
                    : movies.isEmpty && _searchController.text.isNotEmpty
                        ? const EmptyState(
                            icon: Icons.search_off,
                            title: 'Aucun résultat',
                            message: 'Aucun film trouvé pour cette recherche.',
                          )
                        : movies.isEmpty
                            ? const Center(child: Text('Recherchez un film...'))
                            : MovieGrid(movies: movies),
          ),
        ],
      ),
    );
  }
}
