import '../../../../core/entities/no_params.dart';
import '../../../../core/usecases/stream_usecase.dart';
import '../repositories/i_donation_respository.dart';

class GetCountMyDonationsUseCase extends StreamUseCase<int, NoParams> {
  final IDonationRepository repository;

  GetCountMyDonationsUseCase({required this.repository});
  @override
  Stream<int> call(NoParams params) {
    return repository.getCountMyDonations();
  }
}
