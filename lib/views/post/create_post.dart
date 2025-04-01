import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../utils/custom_header.dart';
import '../../utils/footer.dart';
import 'package:permission_handler/permission_handler.dart'; 

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({super.key});

  @override
  _CreatePostPageState createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  File? _image;
  final TextEditingController _captionController = TextEditingController();

  Future<bool> _requestPermission(Permission permission) async {
    final status = await permission.request();
    return status.isGranted;
  }

  Future<void> _pickImage(ImageSource source) async {
    if (source == ImageSource.camera) {
      if (await _requestPermission(Permission.camera)) {
        final pickedFile = await ImagePicker().pickImage(source: source);
        if (pickedFile != null) {
          setState(() {
            _image = File(pickedFile.path);
          });
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Permission caméra refusée.")),
        );
      }
    } else if (source == ImageSource.gallery) {
      if (await _requestPermission(Permission.photos)) {
        final pickedFile = await ImagePicker().pickImage(source: source);
        if (pickedFile != null) {
          setState(() {
            _image = File(pickedFile.path);
          });
        }
      } else {
        // Si la permission est refusée, affiche un message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Permission galerie refusée.")),
        );
      }
    }
  }

  void _uploadPost() {
    if (_image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Veuillez sélectionner une image.")),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Post publié ! 🚀")),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: const Header(), 
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.camera_alt, size: 32),
                  onPressed: () => _pickImage(ImageSource.camera),
                ),
                const SizedBox(width: 20),
                IconButton(
                  icon: const Icon(Icons.image, size: 32),
                  onPressed: () => _pickImage(ImageSource.gallery),
                ),
              ],
            ),

            const SizedBox(height: 20),

            _image != null
                ? Image.file(_image!, height: 250, fit: BoxFit.cover)
                : const Text("Aucune image sélectionnée."),

            const SizedBox(height: 20),

            TextField(
              controller: _captionController,
              decoration: const InputDecoration(
                hintText: "Écrire une légende...",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: _uploadPost,
              child: const Text("Publier"),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomFooter(
        selectedIndex: 0,
        onItemTapped: (index) {},
      ),
    );
  }
}
