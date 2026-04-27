import 'package:flutter/material.dart';
import 'package:flutter_app_base/features/auth/providers/auth.provider.dart';
import 'package:flutter_app_base/features/auth/screens/login.screen.dart';
import 'package:flutter_app_base/features/users/screens/users.screen.dart';
import 'package:provider/provider.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    if (auth.isAuthenticated) {
      return const UsersScreen();
    } else {
      return const LoginScreen();
    }
  }
}
