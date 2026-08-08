import 'package:flutter/material.dart';

class GenreFilter extends StatelessWidget {
  const GenreFilter({
    super.key,
    required this.genres,
    required this.selectedGenre,
    required this.onChanged,
  });

  final List<String> genres;
  final String? selectedGenre;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: selectedGenre,
      decoration: const InputDecoration(
        labelText: 'Genre',
        prefixIcon: Icon(Icons.category_outlined),
      ),
      items: [
        const DropdownMenuItem<String>(
          value: null,
          child: Text('Tous les genres'),
        ),
        ...genres.map(
          (genre) => DropdownMenuItem<String>(value: genre, child: Text(genre)),
        ),
      ],
      onChanged: onChanged,
    );
  }
}
