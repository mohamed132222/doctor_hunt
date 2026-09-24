/// Base failure returned to the application layer.
sealed class Failure {
  final String message;

  const Failure(this.message);

  @override
  String toString() => message;
}

/// Authentication failure.
final class AuthFailure extends Failure {
  const AuthFailure(super.message);
}

/// Network failure.
final class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

/// Server/backend failure.
final class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

/// Validation failure.
final class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}

/// Unknown/unexpected failure.
final class UnknownFailure extends Failure {
  const UnknownFailure(super.message);
}
