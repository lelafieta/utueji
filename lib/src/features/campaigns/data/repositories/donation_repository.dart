import '../../domain/repositories/i_donation_respository.dart';
import '../datasources/i_donation_datasource.dart';

class DonationRepository extends IDonationRepository {
  final IDonationDataSource datasource;

  DonationRepository({required this.datasource});
  @override
  Stream<int> getCountMyDonations() {
    return datasource.getCountMyDonations();
  }
}
