import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppScaffold extends StatelessWidget {
  final Widget body;

  int _getIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();

    if (location.startsWith('/users')) return 0;
    if (location.startsWith('/profile')) return 1;

    return 0;
  }

  const AppScaffold({required this.body, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Appbar")),
      body: Padding(padding: const EdgeInsets.all(16), child: body),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _getIndex(context),
        onDestinationSelected: (index) {
          if (index == 0) context.go('/users');
          if (index == 1) context.go('/profile');
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.people), label: "Usuarios"),
          NavigationDestination(icon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
    );
  }
}
