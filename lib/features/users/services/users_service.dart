import 'package:flutter_app_base/core/contracts/crud_contract.dart';
import 'package:flutter_app_base/core/errors/app_error.dart';
import 'package:flutter_app_base/core/use-cases/api_case.dart';
import 'package:flutter_app_base/features/users/dtos/user_dto.dart';
import 'package:flutter_app_base/features/users/models/user_model.dart';

class UsersService extends ApiCase {
  Future<Result<ListResponse<UserModel>>> list(
    Map<String, String>? queryParams,
  ) async {
    final response = await get("/users", queryParams: queryParams);
    if (response.isError) return Result.failure(response.error);

    response.data["filteredRecords"] =
        (response.data["filteredRecords"] as List)
            .map((e) => UserDTO.fromJson(e).toModel())
            .toList();
    return Result.success(ListResponse.fromJson(response.data));
  }
}
