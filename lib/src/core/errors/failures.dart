import 'package:utueji/src/core/errors/error_messages.dart';

abstract class Failure {
  String? error;

  Failure(this.error);
}

class ServerFailure extends Failure {
  ServerFailure({String? error}) : super(error);
}

class NetworkFailure extends Failure {
  NetworkFailure() : super(ErrorMessages.semConexao);
}

class CacheFailure extends Failure {
  CacheFailure(super.error);
}
