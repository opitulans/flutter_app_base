class UserModel {
  final int id;
  final String name;
  final String lastName;
  final String username;
  final String userType;
  final bool isActive;

  UserModel({
    required this.id,
    required this.username,
    required this.name,
    required this.lastName,
    required this.userType,
    required this.isActive,
  });
}
