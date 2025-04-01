import 'package:flutter/material.dart';
import '../service/comments_service.dart';
import '../service/likes_service.dart';

class PostCard extends StatefulWidget {
  final int postId;
  final int userId;
  final String? profileImageUrl;
  final String? username;
  final String? postImageUrl;
  final int? likesCount;
  final int? commentsCount;
  final int? sharesCount;

  const PostCard({
    Key? key,
    required this.postId,
    required this.userId,
    required this.profileImageUrl,
    required this.username,
    required this.postImageUrl,
    required this.likesCount,
    required this.commentsCount,
    required this.sharesCount,
  }) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  late int likeCount;
  late int commentCount;
  final TextEditingController commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    likeCount = widget.likesCount ?? 0;
    commentCount = widget.commentsCount ?? 0;
  }

  Future<void> likePost() async {
    await LikeService(baseUrl: 'http://localhost:8080/api/v1')
        .likePost(widget.postId, widget.userId);
    setState(() {
      likeCount++;
    });
  }

  Future<void> addComment() async {
    if (commentController.text.isEmpty) return;
    await CommentsService(baseUrl: 'http://localhost:8080/api/v1')
        .addComment(widget.postId.toString(), widget.userId.toString(), commentController.text);
    setState(() {
      commentCount++;
      commentController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Header ---
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    widget.profileImageUrl ?? 'https://via.placeholder.com/150',
                  ),
                  radius: 20,
                ),
                const SizedBox(width: 10),
                Text(
                  widget.username ?? 'Utilisateur',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),

          // --- Post Image ---
          Image.network(widget.postImageUrl ?? 'https://via.placeholder.com/500'),

          // --- Actions ---
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.favorite_border),
                  onPressed: likePost,
                ),
                Text('$likeCount Likes'),
                const SizedBox(width: 20),
                const Icon(Icons.comment_outlined),
                const SizedBox(width: 10),
                Text('$commentCount Comments'),
              ],
            ),
          ),

          // --- Comment section ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              controller: commentController,
              decoration: InputDecoration(
                hintText: 'Ajouter un commentaire...',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: addComment,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
