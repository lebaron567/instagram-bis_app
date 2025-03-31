import 'package:flutter/material.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  final String username;

  const Header({Key? key, required this.username}) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight); // Définit la taille du header (hauteur de la barre d'application)

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Affichage du nom d'utilisateur au centre du header
          Text(
            username.isEmpty ? 'Loading...' : username, // Affiche 'Loading...' tant que le nom n'est pas récupéré
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ],
      ),
      actions: [
        // Bouton de notifications
        IconButton(
          icon: Icon(Icons.notifications_none, color: Colors.black),
          onPressed: () {
            // Actions pour les notifications
          },
        ),
        // Bouton de messages
        IconButton(
          icon: Icon(Icons.message_outlined, color: Colors.black),
          onPressed: () {
            // Actions pour les messages
          },
        ),
      ],
    );
  }
}
