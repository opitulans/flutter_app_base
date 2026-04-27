import 'package:flutter/material.dart';
import 'package:flutter_app_base/core/errors/app.error.dart';
import 'package:flutter_app_base/core/stores/auth.store.dart';
import 'package:flutter_app_base/features/auth/services/auth.service.dart';

class AuthProvider extends ChangeNotifier {
  final _storage = AuthStore();
  final _service = AuthService();

  String? _token;
  bool _isLoading = false;
  AppError? _error;

  bool get isAuthenticated => _token != null;
  bool get isLoading => _isLoading;
  AppError? get error => _error;

  Future<void> init() async {
    _token = await _storage.getToken();
    notifyListeners();
  }

  Future<Result<void>> login(Map<String, String> loginPayload) async {
    _isLoading = true;
    notifyListeners();

    final result = await _service.login(loginPayload);
    _isLoading = false;

    if (result.isError) {
      _error = result.error;
      notifyListeners();
      return Result.failure(result.error);
    }

    _token = result.data!.token;
    _storage.saveToken(result.data!.token);

    notifyListeners();

    return Result.success(null);
  }

  Future<void> logout() async {
    _token = null;
    await _storage.clearToken();
    notifyListeners();
  }
}
