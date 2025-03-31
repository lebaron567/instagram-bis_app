import 'package:flutter/material.dart';

class CommentTile extends StatelessWidget {
  final String username;
  final String comment;

  const CommentTile({
    super.key,
    required this.username,
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      leading: CircleAvatar(
        radius: 20,
        backgroundColor: Colors.grey.shade200,
        child: Text(username[0].toUpperCase(), style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
      title: Text(
        username,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(comment),
    );
  }
}
