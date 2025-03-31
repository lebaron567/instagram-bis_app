import 'package:flutter/material.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  final String profileImageUrl;

  const Header({Key? key, required this.profileImageUrl}) : super(key: key);

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
          // Bouton d'avatar qui affichera la photo de profil
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: CircleAvatar(
              backgroundImage: NetworkImage(profileImageUrl),
              radius: 20, // Taille du cercle
            ),
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
