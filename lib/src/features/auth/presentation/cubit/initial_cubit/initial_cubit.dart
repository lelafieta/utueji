import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/is_sign_in_usecase.dart';
import 'initial_state.dart';

class InitialCubit extends Cubit<InitialState> {
  final IsSignInUseCase isSignInUseCase;

  InitialCubit({
    required this.isSignInUseCase,
  }) : super(InitialApp());

  Future<void> appStarted() async {
    final response = await isSignInUseCase.call();
    response.fold((l) => emit(NotInitialized()), (r) => emit(Initialized()));
  }
}
