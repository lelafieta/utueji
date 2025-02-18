import '../../domain/entities/ong_entity.dart';

abstract class OngState {}

class OngInitial extends OngState {}

class OngLoading extends OngState {}

class OngLoaded extends OngState {
  final List<OngEntity> ongs;

  OngLoaded({required this.ongs});
}

class OngFailure extends OngState {
  final String failure;

  OngFailure({required this.failure});
}
