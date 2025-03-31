import 'package:flutter/material.dart';
import 'views/auth/register_page.dart';
import 'views/feed/feed.dart'; // Ajoute les autres pages ici
import 'views/auth/login_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/register', // Page affichée au démarrage
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/register':
            return MaterialPageRoute(builder: (context) => const RegisterPage());
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
