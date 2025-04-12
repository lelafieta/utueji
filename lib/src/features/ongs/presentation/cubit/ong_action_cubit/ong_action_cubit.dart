import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/ong_entity.dart';
import '../../../domain/usecases/create_ong_usecase.dart';

part 'ong_action_state.dart';

class OngActionCubit extends Cubit<OngActionState> {
  final CreateOngUseCase createOngUseCase;
  OngActionCubit({required this.createOngUseCase}) : super(OngActionInitial());

  Future<void> createOng(OngEntity ong) async {
    emit(OngActionLoading());
    final result = await createOngUseCase.call(ong);

    result.fold((l) => emit(OngActionFailure(error: l.message.toString())),
        (r) => emit(OngActionSuccess()));
  }
}
