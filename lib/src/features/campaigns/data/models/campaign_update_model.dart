import '../../domain/entities/campaign_update_entity.dart';

class CampaignUpdateModel extends CampaignUpdateEntity {
  CampaignUpdateModel({
    super.id,
    super.createdAt,
    super.updatedAt,
    super.title,
    super.description,
  });

  factory CampaignUpdateModel.fromJson(Map<String, dynamic> json) {
    return CampaignUpdateModel(
      id: json['id'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      title: json['title'] as String?,
      description: json['description'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'title': title,
      'description': description,
    };
  }
}
