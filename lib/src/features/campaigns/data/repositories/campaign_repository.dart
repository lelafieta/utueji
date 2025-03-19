import 'package:dartz/dartz.dart';

import 'package:utueji/src/core/errors/failures.dart';

import '../../../../core/network/i_network_info.dart';
import '../../domain/entities/campaign_entity.dart';
import '../../domain/entities/campaign_params.dart';
import '../../domain/repositories/i_campaign_repository.dart';
import '../datasources/i_campaign_datasource.dart';

class CampaignRepository implements ICampaignRepository {
  final ICampaignRemoteDataSource datasource;
  final INetWorkInfo networkInfo;

  CampaignRepository({required this.datasource, required this.networkInfo});

  @override
  Future<Either<Failure, Unit>> createCampaign(CampaignEntity campaign) async {
    if (await networkInfo.isConnected == true) {
      try {
        await datasource.createCampaign(campaign);
        return right(unit);
      } catch (e) {
        return left(ServerFailure(message: e.toString()));
      }
    } else {
      return left(ServerFailure(message: "Sem conexão de internet"));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteCampaign(String id) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<CampaignEntity>>> getAllCampaigns(
      CampaignParams params) async {
    if (await networkInfo.isConnected == true) {
      try {
        final response = await datasource.getAllCampaigns(params);
        return right(response);
      } catch (e) {
        return left(ServerFailure(message: e.toString()));
      }
    } else {
      return left(ServerFailure(message: "Sem conexão de internet"));
    }
  }

  @override
  Future<Either<Failure, List<CampaignEntity>>> getAllUrgentCampaigns(
      CampaignParams params) async {
    if (await networkInfo.isConnected == true) {
      try {
        final response = await datasource.getAllUrgentCampaigns(params);
        return right(response);
      } catch (e) {
        return left(ServerFailure(message: e.toString()));
      }
    } else {
      return left(ServerFailure(message: "Sem conexão de internet"));
    }
  }

  @override
  Future<Either<Failure, CampaignEntity>> getCampaignById(String id) async {
    if (await networkInfo.isConnected == true) {
      try {
        final response = await datasource.getCampaignById(id);
        return right(response);
      } catch (e) {
        return left(ServerFailure(message: e.toString()));
      }
    } else {
      return left(ServerFailure(message: "Sem conexão de internet"));
    }
  }

  @override
  Future<Either<Failure, List<CampaignEntity>>> getLatestUrgentCampaigns(
      CampaignParams params) async {
    // if (await networkInfo.isConnected == true) {
    //   try {
    //     final response = await datasource.getLatestUrgentCampaigns();
    //     return right(response);
    //   } catch (e) {
    //     return left(ServerFailure(message: e.toString()));
    //   }
    // } else {
    //   return left(ServerFailure(message: "Sem conexão de internet"));
    // }
    try {
      final response = await datasource.getLatestUrgentCampaigns(params);
      return right(response);
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateCampaign(CampaignEntity campaign) {
    // TODO: implement updateCampaign
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<CampaignEntity>>> getAllMyCampaigns(
      CampaignParams params) async {
    if (await networkInfo.isConnected == true) {
      try {
        final response = await datasource.getAllMyCampaigns(params);
        return right(response);
      } catch (e) {
        return left(ServerFailure(message: e.toString()));
      }
    } else {
      return left(ServerFailure(message: "Sem conexão de internet"));
    }
  }
}
