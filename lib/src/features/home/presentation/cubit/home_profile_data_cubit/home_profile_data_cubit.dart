import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/entities/no_params.dart';
import '../../../../auth/domain/entities/user_entity.dart';
import '../../../../auth/domain/usecases/get_auth_user_usecase.dart';

part 'home_profile_data_state.dart';

class HomeProfileDataCubit extends Cubit<HomeProfileDataState> {
  final GetAuthUserUseCase getAuthUserUseCase;
  HomeProfileDataCubit({required this.getAuthUserUseCase})
      : super(HomeProfileDataInitial());

  Future<void> getUserProfile() async {
    emit(HomeProfileDataLoading());
    final result = await getAuthUserUseCase.call(const NoParams());

    // result.listen((user) {
    //   print("objecttt");
    //   emit(HomeProfileDataLoaded(user: user));
    // });
  }
}
