import 'package:flutter/material.dart';
import '../../service/auth_service.dart';

class CustomFooter extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomFooter({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  State<CustomFooter> createState() => _CustomFooterState();
}

class _CustomFooterState extends State<CustomFooter> {
  String? userId;

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    final user = await AuthService.getCurrentUser();
    setState(() {
      userId = user?['id']?.toString(); 
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.selectedIndex,
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.pushReplacementNamed(context, '/feed');
            break;
          case 1:
            Navigator.pushReplacementNamed(context, '/search');
            break;
          case 2:
            Navigator.pushNamed(context, '/createPost');
            break;
          case 3:
            Navigator.pushReplacementNamed(context, '/video');
            break;
          case 4:
            if (userId != null) {
              Navigator.pushReplacementNamed(
                context,
                '/profile',
                arguments: {'userId': userId},
              );
            }
            break;
        }
      },
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'recherche'),
        BottomNavigationBarItem(icon: Icon(Icons.add_box), label: 'creer'),
        BottomNavigationBarItem(icon: Icon(Icons.video_collection), label: 'reel'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'profile'),
      ],
    );
  }
}
