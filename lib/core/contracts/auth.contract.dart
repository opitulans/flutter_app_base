class LoginResponse {
  final String token;
  LoginResponse({required this.token});

  factory LoginResponse.fromJson(dynamic json) {
    return LoginResponse(token: json["token"]);
  }
}
