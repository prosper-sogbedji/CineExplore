import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/repositories/movie_repository.dart';

class AddMovieScreen extends StatefulWidget {
  const AddMovieScreen({super.key, required this.repository});

  final MovieRepository repository;

  @override
  State<AddMovieScreen> createState() => _AddMovieScreenState();
}

class _AddMovieScreenState extends State<AddMovieScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _yearController = TextEditingController();
  final _directorController = TextEditingController();
  final _genreController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _durationController = TextEditingController(text: '100');

  @override
  void dispose() {
    _titleController.dispose();
    _yearController.dispose();
    _directorController.dispose();
    _genreController.dispose();
    _descriptionController.dispose();
    _durationController.dispose();
    super.dispose();
  }

  String? _requiredText(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Ce champ est obligatoire';
    }
    return null;
  }

  String? _validateYear(String? value) {
    final requiredError = _requiredText(value);
    if (requiredError != null) {
      return requiredError;
    }
    final year = int.tryParse(value!.trim());
    final currentYear = DateTime.now().year + 2;
    if (year == null) {
      return 'L annee doit etre numerique';
    }
    if (year < 1888 || year > currentYear) {
      return 'Entrez une annee entre 1888 et $currentYear';
    }
    return null;
  }

  String? _validateDuration(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }
    final duration = int.tryParse(value.trim());
    if (duration == null || duration <= 0) {
      return 'La duree doit etre un nombre positif';
    }
    return null;
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    widget.repository.addMovie(
      title: _titleController.text,
      year: int.parse(_yearController.text.trim()),
      director: _directorController.text,
      genre: _genreController.text,
      description: _descriptionController.text,
      duration: int.tryParse(_durationController.text.trim()) ?? 100,
    );
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Film ajoute au catalogue')));
    context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ajouter un film')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Nouveau film',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    key: const Key('titleField'),
                    controller: _titleController,
                    decoration: const InputDecoration(
                      labelText: 'Titre',
                      prefixIcon: Icon(Icons.movie_outlined),
                    ),
                    validator: _requiredText,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    key: const Key('yearField'),
                    controller: _yearController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Annee',
                      prefixIcon: Icon(Icons.calendar_month_outlined),
                    ),
                    validator: _validateYear,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    key: const Key('directorField'),
                    controller: _directorController,
                    decoration: const InputDecoration(
                      labelText: 'Realisateur',
                      prefixIcon: Icon(Icons.person_outline),
                    ),
                    validator: _requiredText,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    key: const Key('genreField'),
                    controller: _genreController,
                    decoration: const InputDecoration(
                      labelText: 'Genre',
                      prefixIcon: Icon(Icons.category_outlined),
                    ),
                    validator: _requiredText,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    key: const Key('durationField'),
                    controller: _durationController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Duree en minutes',
                      prefixIcon: Icon(Icons.schedule_outlined),
                    ),
                    validator: _validateDuration,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    key: const Key('descriptionField'),
                    controller: _descriptionController,
                    minLines: 4,
                    maxLines: 6,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      prefixIcon: Icon(Icons.notes_outlined),
                    ),
                    validator: _requiredText,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    key: const Key('submitMovieButton'),
                    onPressed: _submit,
                    icon: const Icon(Icons.save_outlined),
                    label: const Text('Ajouter le film'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
