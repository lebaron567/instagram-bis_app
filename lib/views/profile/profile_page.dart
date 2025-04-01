import 'package:flutter/material.dart';
import '../../service/user_service.dart';
import '../../utils/footer.dart';


class UserProfile extends StatefulWidget {
  final String userId; 

  const UserProfile({Key? key, required this.userId}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final _userService = UserService();
  Map<String, dynamic>? user;
  bool isLoading = true;
  bool isFollowing = false;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final data = await _userService.getUser(widget.userId);
    setState(() {
      user = data;
      isLoading = false;
    });
  }

  Future<void> _toggleFollow() async {
    final success = await _userService.followUser(widget.userId, "1");
    if (success) {
      setState(() => isFollowing = !isFollowing);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) return const Center(child: CircularProgressIndicator());
    if (user == null) return const Center(child: Text("Utilisateur introuvable"));

    return Scaffold(
      appBar: AppBar(title: Text(user!['pseudo_user'] ?? 'Profil')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(user!['profilpicture_user'] ?? ''),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(user!['pseudo_user'] ?? '',
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text(user!['email_user'] ?? '', style: const TextStyle(color: Colors.grey)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _toggleFollow,
              child: Text(isFollowing ? "Unfollow" : "Follow"),
            ),
            const SizedBox(height: 16),
            const Text("Bio à afficher ici..."), 
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
