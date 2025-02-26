import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:utueji/src/core/entities/no_params.dart';

import '../../domain/usecases/fetch_latest_events_usecase.dart';
import 'event_state.dart';

class EventCubit extends Cubit<EventState> {
  final FetchLatestEventsUsecase fetchLatestEventsUsecase;
  EventCubit({required this.fetchLatestEventsUsecase}) : super(EventInitial());

  Future<void> getLatestEvents() async {
    emit(EventLoading());

    final events = fetchLatestEventsUsecase.call(const NoParams());

    events.listen((event) {
      emit(EventLoaded(events: event));
    });
  }
}
