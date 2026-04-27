import 'package:flutter/foundation.dart';
import 'package:flutter_app_base/core/errors/app.error.dart';
import 'package:flutter_app_base/features/users/models/user.model.dart';
import 'package:flutter_app_base/features/users/services/users.service.dart';

class UsersProvider extends ChangeNotifier {
  final UsersService _service = UsersService();

  List<UserModel> _users = [];
  bool _isLoading = false;
  AppError? _error;

  List<UserModel> get users => _users;
  bool get isLoading => _isLoading;
  AppError? get error => _error;

  void _switchLoading() {
    _isLoading = !_isLoading;
    notifyListeners();
  }

  Future<void> init() async {
    final listParams = {"page": "1"};
    final response = await _service.list(listParams);
    if (response.isError) {
      _error = response.error;
    } else {
      _users = response.data!.filteredRecords;
    }
    notifyListeners();
  }

  Future<void> list(Map<String, String>? queryParams) async {
    _switchLoading();

    final response = await _service.list(queryParams);
    if (response.isError) {
      _error = response.error;
    } else {
      _users = response.data!.filteredRecords;
    }

    _switchLoading();
  }
}
