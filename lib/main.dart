import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'core/router/app_router.dart';
import 'core/theme/theme_controller.dart';
import 'core/theme/app_theme.dart';
import 'core/l10n/app_localizations.dart';
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
    context.watch<AuthProvider>();

    return MaterialApp.router(
      title: 'CineExplore',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeController.themeMode,
      routerConfig: _router,
      // Internationalisation FR + EN
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('fr'),
        Locale('en'),
      ],
    );
  }
}
