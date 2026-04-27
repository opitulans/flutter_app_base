import 'package:flutter/material.dart';
import 'package:flutter_app_base/features/auth/providers/auth.provider.dart';
import 'package:flutter_app_base/features/users/providers/users.provider.dart';
import 'package:provider/provider.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UsersProvider()..init(),
      child: Builder(
        builder: (context) {
          final usersProvider = context.watch<UsersProvider>();
          if (usersProvider.isLoading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          return ListView.builder(
            itemCount: usersProvider.users.length,
            itemBuilder: (context, index) {
              final user = usersProvider.users[index];
              return Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  title: Text("${user.id} - ${user.name} - ${user.lastName}"),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
