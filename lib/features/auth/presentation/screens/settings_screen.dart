import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/theme_controller.dart';
import '../providers/auth_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = context.watch<ThemeController>();
    final auth = context.watch<AuthProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil & Paramètres'),
      ),
      body: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text('Utilisateur Connecté'),
            accountEmail: const Text('Connecté via Token JWT'),
            currentAccountPicture: const CircleAvatar(
              child: Icon(Icons.person, size: 40),
            ),
          ),
          SwitchListTile(
            title: const Text('Mode Sombre'),
            subtitle: const Text('Activer le theme sombre'),
            value: themeController.isDarkMode,
            onChanged: (value) => themeController.setDarkMode(value),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Se déconnecter', style: TextStyle(color: Colors.red)),
            onTap: () async {
              await auth.logout();
              if (context.mounted) {
                context.go('/login');
              }
            },
          ),
        ],
      ),
    );
  }
}
