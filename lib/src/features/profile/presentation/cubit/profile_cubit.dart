import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/entities/no_params.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../../../auth/domain/usecases/get_auth_user_usecase.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetAuthUserUseCase getAuthUserUseCase;
  ProfileCubit({required this.getAuthUserUseCase}) : super(ProfileInitial());

  Future<void> getProfile() async {
    emit(ProfileLoading());
    final result = await getAuthUserUseCase.call(const NoParams());

    // result.listen((user) {
    //   emit(ProfileLoaded(user: user));
    // });
  }
}
