import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:utueji/src/features/auth/domain/entities/user_entity.dart';

import '../../../../../app/app_entity.dart';
import '../../../../../core/entities/no_params.dart';
import '../../../domain/usecases/get_auth_user_usecase.dart';

part 'auth_data_state.dart';

class AuthDataCubit extends Cubit<AuthDataState> {
  final GetAuthUserUseCase getAuthUserUseCase;
  AuthDataCubit({required this.getAuthUserUseCase}) : super(AuthDataInitial());

  Future<void> getUserData() async {
    emit(AuthDataLoading());

    final result = await getAuthUserUseCase(const NoParams());

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
