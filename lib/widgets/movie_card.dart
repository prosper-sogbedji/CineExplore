import 'package:flutter/material.dart';

import '../data/models/movie.dart';
import 'rating_badge.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({super.key, required this.movie, required this.onTap});

  final Movie movie;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    movie.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: colors.surfaceContainerHighest,
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.movie_creation_outlined,
                          size: 48,
                          color: colors.onSurfaceVariant,
                        ),
                      );
                    },
                  ),
                  Positioned(
                    right: 8,
                    top: 8,
                    child: RatingBadge(rating: movie.rating),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        size: 14,
                        color: colors.onSurfaceVariant,
                      ),
                      const SizedBox(width: 4),
                      Text('${movie.year}'),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          movie.genre,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: colors.onSurfaceVariant),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
