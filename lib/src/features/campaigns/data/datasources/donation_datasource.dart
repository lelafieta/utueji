import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/supabase/supabase_consts.dart';
import 'i_donation_datasource.dart';

class DonationDataSource extends IDonationDataSource {
  final SupabaseClient supabase;

  DonationDataSource({required this.supabase});

  @override
  Stream<int> getCountMyDonations() {
    return supabase
        .from(SupabaseConsts.campaignContributors)
        .stream(primaryKey: ['id'])
        .eq('user_id', supabase.auth.currentUser!.id)
        .map((data) {
          print("TAMANHO");
          print(data.length);
          return data.length;
        });
  }
}
