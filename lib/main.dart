import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/search/search_page.dart';
import 'package:flutter_application_1/views/video/video_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../views/auth/login_page.dart';
import './providers/auth_provider.dart';
import './views/profile/profile_page.dart';
import './views/auth/register_page.dart';
import 'views/feed/feed.dart';
import 'views/post/create_post.dart';


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
          : '/login', 
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/register':
            return MaterialPageRoute(
                builder: (context) => const RegisterPage());
          case '/login':
            return MaterialPageRoute(builder: (context) => const LoginPage());
          case '/createPost':
            return MaterialPageRoute(builder: (context) => CreatePostPage());
          case '/feed':
            return MaterialPageRoute(builder: (context) => FeedPage());
          case '/video':
            return MaterialPageRoute(builder: (context) => VideoPage());
          case '/search':
            return MaterialPageRoute(builder: (context) => SearchPage());
          case '/profile':
            final args = settings.arguments as Map<String, dynamic>;
            final userId = args['userId'] as String;
            return MaterialPageRoute(
              builder: (context) => UserProfile(userId: userId),
            );
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
