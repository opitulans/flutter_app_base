import 'dart:async';
import 'dart:convert';
import 'package:flutter_app_base/core/errors/app.error.dart';
import 'package:flutter_app_base/core/stores/auth.store.dart';
import 'package:http/http.dart' as http;

class ApiCase {
  final _authStore = AuthStore();
  String backendUrl = "http://localhost:3000";

  Result<dynamic> _getResultByResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return Result.success(jsonDecode(response.body));
    }

    if (response.statusCode == 401) {
      return Result.failure(UnauthorizedError());
    }
    return Result.failure(ServerError(response.statusCode));
  }

  Future<Map<String, String>> _headers() async {
    String? token = await _authStore.getToken();

    return {
      "Content-Type": "application/json",
      "Authorization": token != null ? "Bearer $token" : "",
    };
  }

  Uri _url(String endpoint, {int? id, Map<String, String>? queryParams}) {
    String baseUrl = "$backendUrl$endpoint";
    if (id != null) {
      baseUrl += "/$id";
    }
    return Uri.parse(baseUrl).replace(queryParameters: queryParams);
  }

  Future<Result<dynamic>> get(
    String endpoint, {
    Map<String, String>? queryParams,
  }) async {
    try {
      final response = await http
          .get(
            _url(endpoint, queryParams: queryParams),
            headers: await _headers(),
          )
          .timeout(const Duration(seconds: 20));
      return _getResultByResponse(response);
    } catch (e) {
      return Result.failure(UnknownError(e.toString()));
    }
  }

  Future<Result<dynamic>> post(
    String endpoint,
    Map<String, String> body, {
    Map<String, String>? queryParams,
  }) async {
    try {
      final response = await http
          .post(
            _url(endpoint, queryParams: queryParams),
            headers: await _headers(),
            body: jsonEncode(body),
          )
          .timeout(const Duration(seconds: 20));

      return _getResultByResponse(response);
    } catch (e) {
      return Result.failure(UnknownError(e.toString()));
    }
  }

  Future<Result<dynamic>> show(
    String endpoint,
    int id, {
    Map<String, String>? queryParams,
  }) async {
    try {
      final response = await http
          .get(
            _url(endpoint, id: id, queryParams: queryParams),
            headers: await _headers(),
          )
          .timeout(const Duration(seconds: 20));
      return _getResultByResponse(response);
    } catch (e) {
      return Result.failure(UnknownError(e.toString()));
    }
  }

  Future<Result<dynamic>> put(
    String endpoint,
    int id,
    Map<String, String> body, {
    Map<String, String>? queryParams,
  }) async {
    try {
      final response = await http.put(
        _url(endpoint, id: id, queryParams: queryParams),
        headers: await _headers(),
        body: body,
      );
      return _getResultByResponse(response);
    } catch (e) {
      return Result.failure(UnknownError(e.toString()));
    }
  }

  Future<Result<dynamic>> delete(
    String endpoint,
    int id, {
    Map<String, String>? queryParams,
  }) async {
    try {
      final response = await http.delete(
        _url(endpoint, id: id, queryParams: queryParams),
        headers: await _headers(),
      );
      return _getResultByResponse(response);
    } catch (e) {
      return Result.failure(UnknownError(e.toString()));
    }
  }
}
