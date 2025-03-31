import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'views/auth/register_page.dart';
import 'views/feed/feed.dart'; // Ajoute les autres pages ici
import 'views/auth/login_page.dart';
=======
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../views/auth/login_page.dart';
//import './views/feed/feed_page.dart';
import './providers/auth_provider.dart';
>>>>>>> 0fae0dd7e36c223b9e5d36fdd49d6b013d31fd61

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
<<<<<<< HEAD
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
=======
  Widget build(BuildContext context, WidgetRef ref) {
    final isAuthenticated = ref.watch(authProvider);

    return MaterialApp(
      title: 'Instagram Bis',
      debugShowCheckedModeBanner: false,
      routes: {
        '/login': (context) => const LoginPage(),
        //'/feed': (context) => const FeedPage(),
        // autres routes...
      },
      //home: isAuthenticated ? const FeedPage() : const LoginPage(),
>>>>>>> 0fae0dd7e36c223b9e5d36fdd49d6b013d31fd61
    );
  }
}
