import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:utueji/src/core/entities/no_params.dart';

import '../../../app/app_entity.dart';
import '../../auth/domain/entities/user_entity.dart';
import '../../auth/domain/usecases/get_auth_user_usecase.dart';

part 'solidary_state.dart';

class SolidaryCubit extends Cubit<SolidaryState> {
  final GetAuthUserUseCase getAuthUserUseCase;
  SolidaryCubit({required this.getAuthUserUseCase}) : super(SolidaryInitial());

  void getUserData() async {
    emit(GetUserDataLoadingState());

    final result = await getAuthUserUseCase(const NoParams());

    result.fold(
      (failure) {
        print("ERROR!!");
        emit(GetUserDataErrorState(error: failure.message.toString()));
      },
      (user) {
        print("CARREGOU!!");
        AppEntity.currentUser = user;
        emit(GetUserDataSuccessState(user: user));
      },
    );
  }
}
