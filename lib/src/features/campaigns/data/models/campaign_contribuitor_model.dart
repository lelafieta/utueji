import 'package:utueji/src/features/auth/data/models/user_model.dart';

import '../../domain/entities/campaign_contributor_entity.dart';

class CampaignContributorModel extends CampaignContributorEntity {
  CampaignContributorModel({
    super.id,
    super.campaignId,
    super.userId,
    super.money,
    super.isAnonymous,
    super.updatedAt,
    super.createdAt,
    super.user,
    super.campaign,
  });

  factory CampaignContributorModel.fromJson(Map<String, dynamic> json) {
    return CampaignContributorModel(
      id: json['id'],
      campaignId: json['campaign_id'],
      userId: json['user_id'],
      money: json['money'],
      isAnonymous: json['is_anonymous'],
      user: (json['user'] == null) ? null : UserModel.fromJson(json['user']),
      campaign: json['campaign'],
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
    );
  }
}
