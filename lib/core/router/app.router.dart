import 'package:flutter_app_base/core/widgets/layout/app_scaffold.dart';
import 'package:flutter_app_base/features/auth/providers/auth.provider.dart';
import 'package:flutter_app_base/features/auth/screens/login.screen.dart';
import 'package:flutter_app_base/features/users/providers/users.provider.dart';
import 'package:flutter_app_base/features/users/screens/users.screen.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AppRouter {
  static GoRouter createRouter(AuthProvider authProvider) {
    return GoRouter(
      refreshListenable: authProvider,
      redirect: (context, state) {
        final isLoggedIn = authProvider.isAuthenticated;
        final isLoggingIn = state.matchedLocation == '/login';

        if (!isLoggedIn && !isLoggingIn) {
          return '/login';
        }

        if (isLoggedIn && isLoggingIn) {
          return '/users';
        }

        return null;
      },

      initialLocation: '/login',
      routes: [
        GoRoute(
          path: '/login',
          builder: (context, state) => const LoginScreen(),
        ),

        ShellRoute(
          builder: (context, state, child) {
            return AppScaffold(body: child);
          },
          routes: [
            GoRoute(
              path: '/users',
              builder: (context, state) => ChangeNotifierProvider(
                create: (_) => UsersProvider()..init(),
                child: const UsersScreen(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
