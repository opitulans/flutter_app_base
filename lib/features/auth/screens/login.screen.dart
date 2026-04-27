import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_app_base/core/errors/app.error.dart';
import 'package:flutter_app_base/features/auth/providers/auth.provider.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void handleError(BuildContext context, AppError error) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(error.message)));
  }

  Future<void> login() async {
    final AuthProvider authProvider = context.read<AuthProvider>();
    final loginPayload = {
      "username": usernameController.text,
      "password": passwordController.text,
    };
    final response = await authProvider.login(loginPayload);
    if (!mounted) return;
    if (response.isError) {
      handleError(context, response.error!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(labelText: "Username"),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Password"),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: login,
              child: authProvider.isLoading
                  ? const CircularProgressIndicator()
                  : const Text("Iniciar sesion"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
