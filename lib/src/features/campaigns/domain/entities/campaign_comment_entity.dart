import '../../../auth/domain/entities/user_entity.dart';

class CampaignCommentEntity {
  final String? id;
  final String? userId;
  final String? campaignId;
  final String? description;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final UserEntity? user;

  CampaignCommentEntity(
      {this.id,
      this.userId,
      this.campaignId,
      this.description,
      this.createdAt,
      this.updatedAt,
      this.user});
}
