// lib/widgets/post_card.dart

import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  final String profileImageUrl;
  final String username;
  final String postImageUrl;
  final int likesCount;
  final int commentsCount;
  final int sharesCount;

  const PostCard({
    Key? key,
    required this.profileImageUrl,
    required this.username,
    required this.postImageUrl,
    required this.likesCount,
    required this.commentsCount,
    required this.sharesCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(profileImageUrl),
                  radius: 20,
                ),
                SizedBox(width: 10),
                Text(
                  username,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Image.network(postImageUrl),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Icon(Icons.favorite_border),
                SizedBox(width: 10),
                Text('$likesCount Likes'),
                SizedBox(width: 20),
                Icon(Icons.comment_outlined),
                SizedBox(width: 10),
                Text('$commentsCount Comments'),
                SizedBox(width: 20),
                Icon(Icons.share_outlined),
                SizedBox(width: 10),
                Text('$sharesCount Shares'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              'View all $commentsCount comments',
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }
}
