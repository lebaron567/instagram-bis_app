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
      id: json['id'],
      username: json['username'],
      bio: json['bio'],
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
