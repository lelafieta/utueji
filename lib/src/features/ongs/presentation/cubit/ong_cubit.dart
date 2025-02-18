import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/fetch_latest_ongs_usecase.dart';
import 'ong_state.dart';

class OngCubit extends Cubit<OngState> {
  final FetchLatestOngsUsecase fetchLatestOngsUsecase;
  OngCubit({required this.fetchLatestOngsUsecase}) : super(OngInitial());

  Future<void> getLatestOngs() async {
    emit(OngLoading());

    final events = fetchLatestOngsUsecase.call();

    events.listen((event) {
      emit(OngLoaded(ongs: event));
    });
  }
}
