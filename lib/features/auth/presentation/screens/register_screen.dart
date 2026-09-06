import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../providers/auth_provider.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailController = TextEditingController(text: 'eve.holt@reqres.in');
  final _passwordController = TextEditingController(text: 'pistol');

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Inscription')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Mot de passe'),
              obscureText: true,
            ),
            const SizedBox(height: 24),
            if (auth.errorMessage != null)
              Text(
                auth.errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            const SizedBox(height: 24),
            auth.isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () async {
                      final success = await context.read<AuthProvider>().register(
                        _emailController.text,
                        _passwordController.text,
                      );
                      if (success) {
                        context.go('/home');
                      }
                    },
                    child: const Text("S'inscrire"),
                  ),
            TextButton(
              onPressed: () => context.go('/login'),
              child: const Text('Déjà un compte ? Connectez-vous'),
            ),
          ],
        ),
      ),
    );
  }
}
