import 'package:flutter/material.dart';
import '../../utils/footer.dart';

class VideoPage extends StatelessWidget {
  const VideoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Vidéos"),
      ),
      body: Center(
        child: const Text(
          "Aucune vidéo disponible.",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      bottomNavigationBar: CustomFooter(
        selectedIndex: 0,
        onItemTapped: (index) {},
      ),
    );
  }
}
