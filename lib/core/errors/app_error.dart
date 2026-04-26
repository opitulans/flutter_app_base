abstract class AppError {
  final String message;
  const AppError(this.message);
}

class NetworkError extends AppError {
  const NetworkError() : super("Sin conexión");
}

class TimeoutErrorApp extends AppError {
  const TimeoutErrorApp() : super("Tiempo de espera agotado");
}

class UnauthorizedError extends AppError {
  const UnauthorizedError() : super("Credenciales inválidas");
}

class ServerError extends AppError {
  const ServerError(int code) : super("Error del servidor ($code)");
}

class UnknownError extends AppError {
  const UnknownError(String message) : super("Error $message");
}

class Result<T> {
  final T? data;
  final AppError? error;
  final bool _isSuccess;

  bool get isSuccess => _isSuccess;
  bool get isError => !_isSuccess;

  Result.success(this.data) : error = null, _isSuccess = true;
  Result.failure(this.error) : data = null, _isSuccess = false;
}
