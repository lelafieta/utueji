import '../../domain/entities/campaign_document_entity.dart';

class CampaignDocumentModel extends CampaignDocumentEntity {
  CampaignDocumentModel(
      {super.id,
      super.createdAt,
      super.updatedAt,
      super.campaignId,
      super.documentPath,
      super.userId,
      super.isApproved});

  factory CampaignDocumentModel.fromJson(Map<String, dynamic> json) {
    return CampaignDocumentModel(
      id: json['id'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      userId: json['user_id'] as String?,
      campaignId: json['campaign_id'] as String?,
      documentPath: json['document_path'] as String?,
      isApproved: json['is_approved'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'document_path': documentPath,
      'campaign_id': campaignId,
      'user_id': userId,
      'is_approved': isApproved,
    };
  }
}
