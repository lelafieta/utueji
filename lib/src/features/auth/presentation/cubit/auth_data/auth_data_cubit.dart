import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../app/app_entity.dart';
import '../../../../../core/entities/no_params.dart';
import '../../../domain/usecases/get_profile_usecase.dart';

part 'auth_data_state.dart';

class AuthDataCubit extends Cubit<AuthDataState> {
  final GetProfileUseCase getProfileUseCase;
  AuthDataCubit({required this.getProfileUseCase}) : super(AuthDataInitial());

  Future<void> getUserData() async {
    emit(AuthDataLoading());

    final result = await getProfileUseCase(const NoParams());

    result.fold(
      (failure) {
        emit(AuthDataError(message: failure.message.toString()));
      },
      (user) {
        print("CARREGOU!!");
        AppEntity.currentUser = user;
        emit(AuthDataLoaded(currentUser: user));
      },
    );
  }
}
