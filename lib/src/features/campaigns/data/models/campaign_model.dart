import '../../../../core/utils/campaign_status_extension.dart';
import '../../../auth/data/models/user_model.dart';
import '../../../categories/data/models/category_model.dart';
import '../../../ongs/data/models/ong_model.dart';
import '../../domain/entities/campaign_entity.dart';
import '../../domain/enums/campaign_status.dart';
import 'campaign_comment_model.dart';
import 'campaign_contribuitor_model.dart';
import 'campaign_document_model.dart';
import 'campaign_midia_model.dart';
import 'campaign_update_model.dart';

class CampaignModel extends CampaignEntity {
  CampaignModel(
      {super.id,
      super.createdAt,
      super.updatedAt,
      super.categoryId,
      super.description,
      super.fundraisingGoal,
      super.fundsRaised,
      super.imageCoverUrl,
      super.institution,
      super.location,
      super.numberOfContributions,
      super.ongId,
      super.beneficiaryName,
      super.birth,
      super.campaignType,
      super.currency,
      super.isActivate,
      super.phoneNumber,
      super.priority = 0,
      super.isUrgent,
      super.endDate,
      super.title,
      super.isFavorited,
      super.userId,
      super.status,
      super.startDate,
      super.category,
      super.ong,
      super.user,
      super.contributors,
      super.documents,
      super.updates,
      super.comments,
      super.midias});

  factory CampaignModel.fromJson(Map<String, dynamic> map) {
    print(map['campaign_type']);
    return CampaignModel(
      id: map['id'],
      createdAt:
          map['created_at'] != null ? DateTime.parse(map['created_at']) : null,
      updatedAt:
          map['updated_at'] != null ? DateTime.parse(map['updated_at']) : null,
      categoryId: map['category_id'],
      description: map['description'],
      fundraisingGoal: (map['fundraising_goal'] != null)
          ? map['fundraising_goal'].toDouble()
          : null,
      fundsRaised:
          (map['funds_raised'] != null) ? map['funds_raised'].toDouble() : null,
      imageCoverUrl: map['image_cover_url'],
      institution: map['institution'],
      location: map['location'],
      isActivate: map['is_activate'],
      numberOfContributions: map['number_of_contributions'],
      ongId: map['ong_id'],
      // isFavorited: map['is_favorited'],
      phoneNumber: map['phone_number'],
      priority: map['priority'] ?? 0,
      isUrgent: map['is_urgent'],
      endDate: map['end_date'] != null ? DateTime.parse(map['end_date']) : null,
      title: map['title'],
      userId: map['user_id'],
      status: CampaignStatusExtension.fromString(map['status'] as String),
      birth: map['birth'] != null ? DateTime.parse(map['birth']) : null,
      currency: map["currency"],
      beneficiaryName: map["beneficiary_name"],
      campaignType: map["campaign_type"],
      startDate:
          map['start_date'] != null ? DateTime.parse(map['start_date']) : null,
      category: map['category'] != null
          ? CategoryModel.fromMap(map['category'])
          : null,
      ong: map['ong'] != null ? OngModel.fromMap(map['ong']) : null,
      user: map['user'] != null ? UserModel.fromJson(map['user']) : null,
      contributors: map['contributors'] != null
          ? List<CampaignContributorModel>.from(map['contributors']
              .map((x) => CampaignContributorModel.fromJson(x)))
          : [],
      documents: map['documents'] != null
          ? List<CampaignDocumentModel>.from(
              map['documents'].map((x) => CampaignDocumentModel.fromJson(x)))
          : [],
      updates: map['updates'] != null
          ? List<CampaignUpdateModel>.from(
              map['updates'].map((x) => CampaignUpdateModel.fromJson(x)))
          : [],
      comments: map['comments'] != null
          ? List<CampaignCommentModel>.from(
              map['comments'].map((x) => CampaignCommentModel.fromJson(x)))
          : [],
      midias: map['midias'] != null
          ? List<CampaignMidiaModel>.from(
              map['midias'].map((x) => CampaignMidiaModel.fromJson(x)))
          : [],
    );
  }

  CampaignModel copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? categoryId,
    String? description,
    double? fundraisingGoal,
    double? fundsRaised,
    String? imageCoverUrl,
    String? institution,
    String? location,
    int? numberOfContributions,
    String? ongId,
    String? phoneNumber,
    int? priority,
    DateTime? endDate,
    String? title,
    String? userId,
    CampaignStatus? status,
    DateTime? startDate,
    CategoryModel? category,
    OngModel? ong,
    UserModel? user,
    List<CampaignContributorModel>? campaignContributors,
  }) {
    return CampaignModel(
      id: id ?? this.id!,
      createdAt: createdAt ?? this.createdAt!,
      updatedAt: updatedAt ?? this.updatedAt!,
      categoryId: categoryId ?? this.categoryId!,
      description: description ?? this.description!,
      fundraisingGoal: fundraisingGoal ?? this.fundraisingGoal!,
      fundsRaised: fundsRaised ?? this.fundsRaised!,
      imageCoverUrl: imageCoverUrl ?? this.imageCoverUrl!,
      institution: institution ?? this.institution!,
      location: location ?? this.location!,
      numberOfContributions:
          numberOfContributions ?? this.numberOfContributions,
      ongId: ongId ?? this.ongId,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      priority: priority ?? this.priority,
      endDate: endDate ?? this.endDate,
      title: title ?? this.title,
      userId: userId ?? this.userId!,
      status: status ?? this.status,
      startDate: startDate ?? this.startDate!,
      category: category ?? this.category!,
      ong: ong ?? this.ong!,
      user: user ?? this.user!,
      contributors: campaignContributors ?? this.contributors!,
    );
  }

  // Method to convert the CampaignModel to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'category_id': categoryId,
      'description': description,
      'fundraising_goal': fundraisingGoal,
      'funds_raised': fundsRaised,
      'image_cover_url': imageCoverUrl,
      'institution': institution,
      'location': location,
      'status': status,
      'number_of_contributions': numberOfContributions,
      'ong_id': ongId,
      'phone_number': phoneNumber,
      'priority': priority,
      'is_urgent': isUrgent,
      'is_activate': isActivate,
      'end_date': endDate?.toIso8601String(),
      'birth': birth?.toIso8601String(),
      'currency': currency,
      'campaign_type': campaignType,
      'beneficiary_name': beneficiaryName,
      'title': title,
      'user_id': userId,
      'start_date': startDate?.toIso8601String(),
    };
  }
}
