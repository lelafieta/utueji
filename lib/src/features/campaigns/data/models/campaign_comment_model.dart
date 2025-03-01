import '../../../auth/data/models/user_model.dart';
import '../../domain/entities/campaign_comment_entity.dart';

class CampaignCommentModel extends CampaignCommentEntity {
  CampaignCommentModel(
      {super.id,
      super.userId,
      super.campaignId,
      super.description,
      super.createdAt,
      super.updatedAt,
      super.user});

  factory CampaignCommentModel.fromJson(Map<String, dynamic> json) {
    return CampaignCommentModel(
      id: json['id'] as String?,
      userId: json['user_id'] as String?,
      campaignId: json['campaign_id'] as String?,
      description: json['description'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'campaignId': campaignId,
      'description': description,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}
