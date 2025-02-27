import '../../../auth/domain/entities/user_entity.dart';
import '../../../categories/domain/entities/category_entity.dart';
import '../../../ongs/domain/entities/ong_entity.dart';
import 'campaign_contributor_entity.dart';

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
  DateTime? endDate;
  String? title;
  String? userId;
  DateTime? startDate;
  CategoryEntity? category;
  OngEntity? ong;
  UserEntity? user;
  List<CampaignContributorEntity>? campaignContributors;

  CampaignEntity(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.categoryId,
      this.description,
      this.fundraisingGoal,
      this.fundsRaised,
      this.imageCoverUrl,
      this.institution,
      this.location,
      this.isFavorited,
      this.numberOfContributions,
      this.ongId,
      this.phoneNumber,
      this.priority = 0,
      this.endDate,
      this.title,
      this.userId,
      this.startDate,
      this.category,
      this.ong,
      this.user,
      this.campaignContributors});
}
