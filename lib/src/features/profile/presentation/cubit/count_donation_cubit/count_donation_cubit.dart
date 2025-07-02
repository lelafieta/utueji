import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/entities/no_params.dart';
import '../../../../campaigns/domain/usecases/get_count_my_donations_usecase.dart';
part 'count_donation_state.dart';

class CountDonationCubit extends Cubit<CountDonationState> {
  final GetCountMyDonationsUseCase getCountMyDonationsUseCase;
  CountDonationCubit({required this.getCountMyDonationsUseCase})
      : super(CountDonationInitial());

  Future<void> counter() async {
    emit(CountDonationLoading());
    final result = getCountMyDonationsUseCase.call(const NoParams());

    result.listen((counter) {
      print("chegou!! $counter");
      emit(CountDonationSuccess(counter: counter));
    });
  }
}
