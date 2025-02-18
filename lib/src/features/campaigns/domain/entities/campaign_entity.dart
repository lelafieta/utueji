import '../../../auth/domain/entities/user_entity.dart';
import '../../../categories/domain/entities/category_entity.dart';
import '../../../ongs/domain/entities/ong_entity.dart';

class CampaignEntity {
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? categoryId;
  final String? description;
  final double? fundraisingGoal;
  final double? fundsRaised;
  final String? imageCoverUrl;
  final String? institution;
  final String? location;
  final int? numberOfContributions;
  final String? ongId;
  final String? phoneNumber;
  final int? priority;
  final DateTime? endDate;
  final String? title;
  final String? userId;
  final DateTime? startDate;
  final CategoryEntity? category;
  final OngEntity? ong;
  final UserEntity? user;

  CampaignEntity({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.categoryId,
    this.description,
    this.fundraisingGoal,
    this.fundsRaised,
    this.imageCoverUrl,
    this.institution,
    this.location,
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
  });
}
