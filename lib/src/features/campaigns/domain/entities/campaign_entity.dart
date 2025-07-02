import '../../../auth/domain/entities/user_entity.dart';
import '../../../categories/domain/entities/category_entity.dart';
import '../../../ongs/domain/entities/ong_entity.dart';
import '../enums/campaign_status.dart';
import 'campaign_comment_entity.dart';
import 'campaign_contributor_entity.dart';
import 'campaign_document_entity.dart';
import 'campaign_midia_entity.dart';
import 'campaign_update_entity.dart';

class CampaignEntity {
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? categoryId;
  String? description;
  double? fundraisingGoal;
  double? fundsRaised;
  String? imageCoverUrl;
  String? institution;
  String? location;
  bool? isFavorited;
  int? numberOfContributions;
  String? ongId;
  String? phoneNumber;
  int? priority;
  bool? isUrgent;
  bool? isActivate;
  DateTime? endDate;
  DateTime? birth;
  String? currency;
  String? campaignType;
  String? beneficiaryName;
  String? title;
  String? userId;
  CampaignStatus? status;
  DateTime? startDate;
  CategoryEntity? category;
  OngEntity? ong;
  UserEntity? user;
  List<CampaignContributorEntity>? contributors;
  List<CampaignDocumentEntity>? documents;
  List<CampaignUpdateEntity>? updates;
  List<CampaignCommentEntity>? comments;
  List<CampaignMidiaEntity>? midias;

  CampaignEntity(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.categoryId,
      this.description,
      this.isUrgent,
      this.fundraisingGoal,
      this.fundsRaised,
      this.imageCoverUrl,
      this.institution,
      this.location,
      this.isFavorited,
      this.isActivate,
      this.numberOfContributions,
      this.ongId,
      this.phoneNumber,
      this.beneficiaryName,
      this.priority = 0,
      this.endDate,
      this.title,
      this.userId,
      this.status,
      this.startDate,
      this.category,
      this.ong,
      this.birth,
      this.campaignType,
      this.currency,
      this.user,
      this.contributors,
      this.documents,
      this.updates,
      this.comments,
      this.midias});
}
