import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../views/auth/login_page.dart';
import './providers/auth_provider.dart';
import './views/profile/profile_page.dart';
import './views/auth/register_page.dart';
import 'views/auth/register_page.dart';
import 'views/feed/feed.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAuthenticated = ref.watch(authProvider);

    return MaterialApp(
      title: 'Instagram Bis',
      debugShowCheckedModeBanner: false,
      initialRoute: isAuthenticated
          ? '/feed'
          : '/login', // Affiche la page selon l'état d'authentification
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/register':
            return MaterialPageRoute(
                builder: (context) => const RegisterPage());
          case '/login':
            return MaterialPageRoute(builder: (context) => const LoginPage());
          case '/feed':
            return MaterialPageRoute(builder: (context) => FeedPage());
          default:
            return MaterialPageRoute(
              builder: (context) => const Scaffold(
                body: Center(child: Text("404 - Page introuvable")),
              ),
            );
        }
      },
    );
  }
}
