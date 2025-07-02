import 'package:utueji/src/core/errors/error_messages.dart';

abstract class Failure {
  String? message;

  Failure(this.message);
}

class ServerFailure extends Failure {
  ServerFailure({String? message}) : super(message);
}

class NetworkFailure extends Failure {
  NetworkFailure() : super(ErrorMessages.semConexao);
}

class CacheFailure extends Failure {
  CacheFailure(super.error);
}
