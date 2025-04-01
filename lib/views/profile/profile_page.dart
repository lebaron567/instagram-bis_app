import 'package:flutter/material.dart';
import '../../service/user_service.dart';
import '../../models/user_model.dart';
import '../../utils/footer.dart';

class UserProfile extends StatefulWidget {
  final String userId;

  const UserProfile({Key? key, required this.userId}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final _userService = UserService();
  UserModel? user;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    try {
      final data = await _userService.getUser(widget.userId);
      setState(() {
        user = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = "Erreur lors du chargement de l'utilisateur : $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (errorMessage != null) {
      return Scaffold(
        body: Center(child: Text(errorMessage!)),
      );
    }

    if (user == null) {
      return const Scaffold(
        body: Center(child: Text("Utilisateur introuvable")),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(user!.username)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  child: Text(
                    user!.username[0].toUpperCase(),
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user!.username,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "ID: ${user!.id}",
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              user!.bio ?? "Aucune bio disponible",
              style: const TextStyle(fontSize: 16),
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
