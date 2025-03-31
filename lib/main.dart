import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../views/auth/login_page.dart';
//import './views/feed/feed_page.dart';
import './providers/auth_provider.dart';
import './views/profile/profile_page.dart';
import './views/auth/register_page.dart';

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
      routes: {
        '/': (context) => UserProfile(user: {
          'username': 'John Doe',
          'avatar': 'https://example.com/avatar.jpg',
          'followers': 100,
          'following': 50,
          'bio': 'This is a sample bio.',
        }),
        // Remplacez 'userId' par l'ID utilisateur réel
        // Remplacez '12345' par l'ID utilisateur réel
        //'/login': (context) => const LoginPage(),
        //'/feed': (context) => const FeedPage(),
        //'/': (context) => const RegisterPage(),
        // autres routes...
      },
      //home: isAuthenticated ? const FeedPage() : const LoginPage(),
    );
  }
}
