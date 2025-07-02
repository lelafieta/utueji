import '../../domain/entities/campaign_update_entity.dart';

class CampaignUpdateModel extends CampaignUpdateEntity {
  CampaignUpdateModel({
    super.id,
    super.createdAt,
    super.updatedAt,
    super.title,
    super.description,
    super.campaignId,
    super.userId,
  });

  factory CampaignUpdateModel.fromJson(Map<String, dynamic> json) {
    return CampaignUpdateModel(
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      title: json['title'] as String?,
      description: json['description'] as String?,
      campaignId: json['campaign_id'] as String?,
      userId: json['user_id'] as String?,
    );
  }

  factory CampaignUpdateModel.fromEntity(CampaignUpdateEntity entity) {
    return CampaignUpdateModel(
      id: entity.id,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      title: entity.title,
      description: entity.description,
      campaignId: entity.campaignId,
      userId: entity.userId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'campaign_id': campaignId,
      'user_id': userId,
    };
  }
}
