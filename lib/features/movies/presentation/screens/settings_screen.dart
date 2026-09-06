import 'package:flutter/material.dart';

import '../state/theme_controller.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key, required this.themeController});

  final ThemeController themeController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Parametres')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              child: const Icon(Icons.person),
            ),
            title: const Text('Camille Martin'),
            subtitle: const Text('Exploratrice cinema - Paris'),
          ),
          const SizedBox(height: 12),
          Card(
            child: SwitchListTile(
              title: const Text('Mode sombre'),
              subtitle: const Text(
                'Appliquer le theme sombre a toute l application',
              ),
              value: themeController.isDarkMode,
              onChanged: themeController.setDarkMode,
              secondary: const Icon(Icons.dark_mode_outlined),
            ),
          ),
          const SizedBox(height: 12),
          const Card(
            child: ListTile(
              leading: Icon(Icons.info_outline),
              title: Text('CineExplore'),
              subtitle: Text(
                'Version 1.0.0 - catalogue local, recherche, filtres, formulaire et navigation GoRouter.',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
