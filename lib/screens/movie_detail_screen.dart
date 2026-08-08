import 'package:flutter/material.dart';

import '../data/repositories/movie_repository.dart';
import '../widgets/empty_state.dart';
import '../widgets/rating_badge.dart';

class MovieDetailScreen extends StatelessWidget {
  const MovieDetailScreen({
    super.key,
    required this.repository,
    required this.movieId,
  });

  final MovieRepository repository;
  final String movieId;

  @override
  Widget build(BuildContext context) {
    final movie = repository.findById(movieId);
    if (movie == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Film introuvable')),
        body: EmptyState(
          icon: Icons.error_outline,
          title: 'Film inexistant',
          message: 'Aucun film ne correspond a l identifiant $movieId.',
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(movie.title)),
      body: SingleChildScrollView(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = MediaQuery.sizeOf(context).width >= 760;
            final poster = AspectRatio(
              aspectRatio: 2 / 3,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  movie.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Theme.of(
                      context,
                    ).colorScheme.surfaceContainerHighest,
                    alignment: Alignment.center,
                    child: const Icon(Icons.movie_outlined, size: 64),
                  ),
                ),
              ),
            );
            final details = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        movie.title,
                        style: Theme.of(context).textTheme.headlineMedium
                            ?.copyWith(fontWeight: FontWeight.w800),
                      ),
                    ),
                    RatingBadge(rating: movie.rating),
                  ],
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    Chip(label: Text(movie.genre)),
                    Chip(label: Text('${movie.year}')),
                    Chip(label: Text('${movie.duration} min')),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  'Realise par ${movie.director}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 16),
                Text(
                  movie.description,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            );

            return Padding(
              padding: const EdgeInsets.all(16),
              child: isWide
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(width: 300, child: poster),
                        const SizedBox(width: 24),
                        Expanded(child: details),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [poster, const SizedBox(height: 20), details],
                    ),
            );
          },
        ),
      ),
    );
  }
}
