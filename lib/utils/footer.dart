import 'package:flutter/material.dart';

class CustomFooter extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomFooter({super.key, required this.selectedIndex, required this.onItemTapped});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.pushReplacementNamed(context, '/feed'); 
            break;
          case 1:
            Navigator.pushReplacementNamed(context, '/search'); 
            break;
          case 2:
            Navigator.pushReplacementNamed(context, '/create'); 
            break;
          case 3:
            Navigator.pushReplacementNamed(context, '/videos'); 
            break;
          case 4:
            Navigator.pushReplacementNamed(context, '/profile'); 
            break;
        }
      },
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home)),
        BottomNavigationBarItem(icon: Icon(Icons.search)),
        BottomNavigationBarItem(icon: Icon(Icons.add_box)),
        BottomNavigationBarItem(icon: Icon(Icons.video_collection)),
        BottomNavigationBarItem(icon: Icon(Icons.person)),
      ],
    );
  }
}
