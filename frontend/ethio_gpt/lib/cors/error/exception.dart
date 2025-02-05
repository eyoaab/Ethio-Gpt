// Base class for custom exceptions
abstract class AppException implements Exception {
  final String errorMessage;
  AppException(this.errorMessage);
}

// Specific exception for server-related errors
class ServerException extends AppException {
  ServerException(super.errorMessage);

  @override
  String toString() => ' $errorMessage';
}

// Specific exception for cache-related errors
class CacheException extends AppException {
  CacheException(super.errorMessage);
  @override
  String toString() => ' $errorMessage';
}

// Specific exception for network-related errors
class NetworkException extends AppException {
  NetworkException(super.errorMessage);
  @override
  String toString() => ' $errorMessage';
}
