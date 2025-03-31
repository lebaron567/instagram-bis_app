import 'package:flutter/material.dart';
//import 'package:flutter_application_1/service/posts_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//import '../views/auth/login_page.dart';
//import './views/feed/feed_page.dart';
import './providers/auth_provider.dart';
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
        '/': (context) => const RegisterPage(),
        //'/feed': (context) => const FeedPage(),
        // autres routes...
      },
      //home: isAuthenticated ? const FeedPage() : const LoginPage(),
    );
  }
}
