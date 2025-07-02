import '../../domain/entities/event_entity.dart';

abstract class EventState {}

class EventInitial extends EventState {}

class EventLoading extends EventState {}

class EventLoaded extends EventState {
  final List<EventEntity> events;

  EventLoaded({required this.events});
}

class EventFailure extends EventState {
  final String failure;

  EventFailure({required this.failure});
}
