import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/entities/no_params.dart';
import '../../../domain/usecases/is_sign_in_usecase.dart';
import 'initial_state.dart';

class InitialCubit extends Cubit<InitialState> {
  final IsSignInUseCase isSignInUseCase;

  InitialCubit({
    required this.isSignInUseCase,
  }) : super(InitialApp());

  Future<void> appStarted() async {
    final response = await isSignInUseCase.call(const NoParams());
    response.fold(
      (l) => emit(NotInitialized()),
      (r) {
        if (r == true) {
          emit(Initialized());
        } else {
          emit(NotInitialized());
        }
      },
    );
  }
}
