/// Base exception for application-level exceptions.
sealed class AppException implements Exception {
  final String message;

  const AppException(this.message);

  @override
  String toString() => message;
}

/// Network/connectivity exception.
final class NetworkException extends AppException {
  const NetworkException(super.message);
}

/// Server/backend exception.
final class ServerException extends AppException {
  const ServerException(super.message);
}

/// Validation exception.
final class ValidationException extends AppException {
  const ValidationException(super.message);
}

/// Unknown/unexpected exception.
final class UnknownException extends AppException {
  const UnknownException(super.message);
}
