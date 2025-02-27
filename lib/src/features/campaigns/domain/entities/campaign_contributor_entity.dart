import 'package:firebase_auth/firebase_auth.dart';
import 'package:utueji/src/features/auth/domain/entities/user_entity.dart';

import 'campaign_entity.dart';

class CampaignContributorEntity {
  String? id;
  String? campaignId;
  String? userId;
  num? money;
  DateTime? createdAt;
  DateTime? updatedAt;
  UserEntity? user;
  CampaignEntity? campaign;

  CampaignContributorEntity({
    this.id,
    this.campaignId,
    this.userId,
    this.money,
    this.createdAt,
    this.updatedAt,
    this.campaign,
    this.user,
  });
}
