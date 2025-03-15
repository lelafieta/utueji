import '../../domain/entities/campaign_midia_entity.dart';

class CampaignMidiaModel extends CampaignMidiaEntity {
  CampaignMidiaModel(
      {super.id,
      super.createdAt,
      super.updatedAt,
      super.midiaUrl,
      super.campaignId,
      super.userId,
      super.midiaType});

  factory CampaignMidiaModel.fromJson(Map<String, dynamic> json) {
    return CampaignMidiaModel(
      id: json['id'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      campaignId: json['campaign_id'] as String?,
      userId: json['user_id'] as String?,
      midiaUrl: json['midia_url'] as String?,
      midiaType: json['midia_type'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'campaign_id': campaignId,
      'midia_url': midiaUrl,
      'midia_type': midiaType,
      'user_id': userId,
    };
  }
}
