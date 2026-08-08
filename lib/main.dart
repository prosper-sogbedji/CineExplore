import 'package:flutter/material.dart';

import 'data/repositories/movie_repository.dart';
import 'router/app_router.dart';
import 'state/theme_controller.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(CineExploreApp());
}

class CineExploreApp extends StatefulWidget {
  CineExploreApp({super.key})
    : repository = MovieRepository(),
      themeController = ThemeController();

  final MovieRepository repository;
  final ThemeController themeController;

  @override
  State<CineExploreApp> createState() => _CineExploreAppState();
}

class _CineExploreAppState extends State<CineExploreApp> {
  late final _router = createAppRouter(
    repository: widget.repository,
    themeController: widget.themeController,
  );

  @override
  void initState() {
    super.initState();
    widget.themeController.addListener(_refreshTheme);
  }

  @override
  void dispose() {
    widget.themeController.removeListener(_refreshTheme);
    super.dispose();
  }

  void _refreshTheme() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'CineExplore',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: widget.themeController.themeMode,
      routerConfig: _router,
    );
  }
}
