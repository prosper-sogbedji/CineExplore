import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../shared/widgets/empty_state.dart';
import '../../../../shared/widgets/movie_grid.dart';
import '../providers/movie_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MovieProvider>().fetchTrendingMovies();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MovieProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Films Tendances (TMDB)'),
        actions: [
          IconButton(
            tooltip: 'Actualiser',
            icon: const Icon(Icons.refresh),
            onPressed: () => provider.fetchTrendingMovies(),
          ),
        ],
      ),
      body: Column(
        children: [
          if (provider.isOfflineFallback)
            Container(
              color: Colors.orange,
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              child: const Text(
                'Mode Hors-ligne : Affichage des données en cache.',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
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
                    : provider.trendingMovies.isEmpty
                        ? const EmptyState(
                            icon: Icons.movie_filter_outlined,
                            title: 'Aucun résultat',
                            message: 'Aucun film trouvé.',
                          )
                        : MovieGrid(movies: provider.trendingMovies),
          ),
        ],
      ),
    );
  }
}
