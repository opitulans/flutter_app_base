import 'package:flutter_app_base/features/users/models/user.model.dart';

class UserDTO {
  final int id;
  final String name;
  final String lastName;
  final String username;
  final String userType;
  final bool isActive;

  UserDTO({
    required this.id,
    required this.username,
    required this.name,
    required this.lastName,
    required this.userType,
    required this.isActive,
  });

  factory UserDTO.fromJson(Map<String, dynamic> json) {
    return UserDTO(
      id: json['id'],
      username: json['username'],
      name: json['name'],
      lastName: json['lastName'],
      userType: json['userType'],
      isActive: json['isActive'],
    );
  }
}

extension UserDtoMapper on UserDTO {
  UserModel toModel() {
    return UserModel(
      id: id,
      username: username,
      name: name,
      lastName: lastName,
      userType: userType,
      isActive: isActive,
    );
  }
}
