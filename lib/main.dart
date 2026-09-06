import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/router/app_router.dart';
import 'core/theme/theme_controller.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/presentation/providers/auth_provider.dart';
import 'features/movies/presentation/providers/movie_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeController()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => MovieProvider()),
      ],
      child: const CineExploreApp(),
    ),
  );
}

class CineExploreApp extends StatefulWidget {
  const CineExploreApp({super.key});

  @override
  State<CineExploreApp> createState() => _CineExploreAppState();
}

class _CineExploreAppState extends State<CineExploreApp> {
  late final _router = createAppRouter();

  @override
  Widget build(BuildContext context) {
    final themeController = context.watch<ThemeController>();
    
    // We listen to AuthProvider in the router, but we must also ensure 
    // GoRouter refreshes on auth state change. For simplicity here, 
    // context.watch<AuthProvider>() will trigger a rebuild of MaterialApp, 
    // which rebuilds the router.
    context.watch<AuthProvider>();

    return MaterialApp.router(
      title: 'CineExplore',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeController.themeMode,
      routerConfig: _router,
    );
  }
}
