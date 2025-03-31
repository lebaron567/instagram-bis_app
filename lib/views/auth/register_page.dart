import 'package:flutter/material.dart';
import '../../service/auth_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final pseudoController = TextEditingController();
  final birthdateController = TextEditingController();

  bool isPrivate = false;
  bool wantsNotify = true;
  bool isLoading = false;

  void register() async {
    setState(() => isLoading = true);

    final success = await AuthService.register({
      "email_user": emailController.text,
      "password_user": passwordController.text,
      "firstname_user": firstNameController.text,
      "lastename_user": lastNameController.text,
      "pseudo_user": pseudoController.text,
      "birthdate": birthdateController.text,
      "isprivate_user": isPrivate,
      "profilpicture_user": "", // Tu peux ajouter un champ d'upload plus tard
      "wantsnotify_user": wantsNotify,
    });

    setState(() => isLoading = false);

    if (success) {
      //Navigator.pushReplacementNamed(context, '/feed');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Inscription échouée")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ListView(
          children: [
            const Text("Inscription", style: TextStyle(fontSize: 24)),
            TextField(controller: lastNameController, decoration: const InputDecoration(labelText: "Nom")),
            TextField(controller: firstNameController, decoration: const InputDecoration(labelText: "Prénom")),
            TextField(controller: emailController, decoration: const InputDecoration(labelText: "Email")),
            TextField(controller: pseudoController, decoration: const InputDecoration(labelText: "Pseudo")),
            TextField(controller: birthdateController, decoration: const InputDecoration(labelText: "Date de naissance (YYYY-MM-DD)")),
            TextField(controller: passwordController, obscureText: true, decoration: const InputDecoration(labelText: "Mot de passe")),
            SwitchListTile(
              title: const Text("Profil privé"),
              value: isPrivate,
              onChanged: (val) => setState(() => isPrivate = val),
            ),
            SwitchListTile(
              title: const Text("Recevoir des notifications"),
              value: wantsNotify,
              onChanged: (val) => setState(() => wantsNotify = val),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: isLoading ? null : register,
              child: isLoading ? const CircularProgressIndicator() : const Text("S'inscrire"),
            ),
          ],
        ),
      ),
    );
  }
}
