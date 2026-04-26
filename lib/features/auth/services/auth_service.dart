import 'package:flutter_app_base/core/contracts/auth_contract.dart';
import 'package:flutter_app_base/core/errors/app_error.dart';
import 'package:flutter_app_base/core/use-cases/api_case.dart';

class AuthService extends ApiCase {
  Future<Result<LoginResponse>> login(Map<String, String> loginPayload) async {
    final response = await post("/auth/login", loginPayload);

    if (response.isError) return Result.failure(response.error);
    print(response.data["token"]);
    return Result.success(LoginResponse.fromJson(response.data));
  }
}
