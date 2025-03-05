import 'package:dartz/dartz.dart';
import 'package:utueji/src/features/campaigns/data/models/campaign_update_model.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/network/i_network_info.dart';
import '../../domain/entities/campaign_update_entity.dart';
import '../../domain/repositories/i_update_repository.dart';
import '../datasources/i_update_datasource.dart';

class UpdateRepository extends IUpdateRepository {
  final IUpdateDataSource datasource;
  final INetWorkInfo netWorkInfo;

  UpdateRepository({required this.datasource, required this.netWorkInfo});
  @override
  Future<Either<Failure, Unit>> create(CampaignUpdateEntity update) async {
    try {
      final response =
          await datasource.create(CampaignUpdateModel.fromEntity(update));

      return right(response);
    } catch (e) {
      return left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<CampaignUpdateEntity>>> listCampaignUpdates(
      String id) {
    // TODO: implement listCampaignUpdates
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> update(CampaignUpdateEntity update) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
