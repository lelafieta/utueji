import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'profile_data_state.dart';

class ProfileDataCubit extends Cubit<ProfileDataState> {
  ProfileDataCubit() : super(ProfileDataInitial());
}
