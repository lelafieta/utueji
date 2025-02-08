import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/is_sign_in_usecase.dart';
import 'initial_state.dart';

class InitialCubit extends Cubit<InitialState> {
  final IsSignInUseCase isSignInUseCase;

  InitialCubit({
    required this.isSignInUseCase,
  }) : super(InitialApp());

  Future<void> appStarted() async {
    try {
      bool isSignIn = await isSignInUseCase.call();
      if (isSignIn == true) {
        emit(Initialized());
      } else {
        emit(NotInitialized());
      }
    } catch (e) {
      emit(InitialFailure());
    }
  }
}
