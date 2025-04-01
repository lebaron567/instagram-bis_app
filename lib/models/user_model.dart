class UserModel {
  final int id;
  final String username;
  final String? bio;

  UserModel({
    required this.id,
    required this.username,
    this.bio,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0, // <- sécurité en cas de null
      username: json['pseudo_user'] ?? 'Utilisateur',
      bio: json['bio'], // ou json['bio_user'] si besoin
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'bio': bio,
    };
  }
}
