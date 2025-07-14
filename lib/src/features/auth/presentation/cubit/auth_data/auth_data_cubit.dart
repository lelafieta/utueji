import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/entities/no_params.dart';
import '../../../domain/entities/user_entity.dart';
import '../../../domain/usecases/get_profile_usecase.dart';

part 'auth_data_state.dart';

class AuthDataCubit extends Cubit<AuthDataState> {
  final GetProfileUseCase getProfileUseCase;
  AuthDataCubit({required this.getProfileUseCase}) : super(AuthDataInitial());

  Future<void> getProfile() async {
    emit(AuthDataLoading());
    final result = await getProfileUseCase(const NoParams());
    result.fold(
      (failure) => emit(AuthDataError(message: failure.toString())),
      (user) => emit(AuthDataLoaded(currentUser: user)),
    );
  }
}
