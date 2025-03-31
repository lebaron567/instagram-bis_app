import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  final Map<String, dynamic> user;

  const UserProfile({Key? key, required this.user}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  bool isFollowing = false;

  void toggleFollow() {
    setState(() {
      isFollowing = !isFollowing;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> posts = widget.user['posts'] ?? [];

    return Scaffold(
      appBar: AppBar(title: Text(widget.user['username'])),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(widget.user['avatar']),
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.user['username'],
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Text("${widget.user['followers']} Followers", style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(width: 16),
                        Text("${widget.user['following']} Following", style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(widget.user['bio'], style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: toggleFollow,
              style: ElevatedButton.styleFrom(
                backgroundColor: isFollowing ? Colors.white : Colors.blue,
                foregroundColor: isFollowing ? Colors.black : Colors.white,
                side: BorderSide(color: Colors.blue),
              ),
              child: Text(isFollowing ? 'Unfollow' : 'Follow'),
            ),
            SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
                ),
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  return Image.network(posts[index], fit: BoxFit.cover);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}