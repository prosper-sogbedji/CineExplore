import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../providers/auth_provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailController = TextEditingController(text: 'eve.holt@reqres.in');
  final _passwordController = TextEditingController(text: 'pistol');

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Inscription'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Semantics(
              label: 'Champ email',
              child: TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
            ),
            const SizedBox(height: 16),
            Semantics(
              label: 'Champ mot de passe',
              child: TextField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Mot de passe'),
                obscureText: true,
              ),
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
                : Semantics(
                    label: "Bouton s'inscrire",
                    child: ElevatedButton(
                      onPressed: () async {
                        final success = await context.read<AuthProvider>().register(
                          _emailController.text,
                          _passwordController.text,
                        );
                        if (success && context.mounted) {
                          context.go('/home');
                        }
                      },
                      child: const Text("S'inscrire"),
                    ),
                  ),
            Semantics(
              label: 'Lien déjà un compte',
              child: TextButton(
                onPressed: () => context.go('/login'),
                child: const Text('Déjà un compte ? Connectez-vous'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
