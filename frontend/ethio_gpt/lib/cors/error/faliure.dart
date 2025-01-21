abstract class Failure {
  final String message;

  const Failure(this.message);

  @override
  String toString() => 'Failure: $message';
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class ConnectionFailure extends Failure {
  const ConnectionFailure(super.message);
}

class UnknownFailure extends Failure {
  const UnknownFailure(super.message);
}

class CacheFailure extends Failure {
  const CacheFailure(super.message);
}
