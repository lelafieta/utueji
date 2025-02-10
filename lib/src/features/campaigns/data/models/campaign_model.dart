import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../ongs/data/models/ong_model.dart';
import '../../../users/data/models/user_profile_model.dart';
import '../../domain/entities/campaign_entity.dart';

class CampaignModel extends CampaignEntity {
  CampaignModel({
    super.id,
    super.title,
    super.description,
    super.categoryName,
    super.institution,
    super.location,
    super.ongId,
    super.priority,
    super.fundraisingGoal,
    super.fundsRaised,
    super.raisedPercentage,
    super.numberOfContributions,
    super.contributionsUsers,
    super.imageCoverUrl,
    super.imagesUrl,
    super.documentsUrl,
    super.phones,
    super.createdAt,
    super.timeLeft,
    super.ong,
    super.user,
    super.userId,
  });

  factory CampaignModel.fromJson(Map<String, dynamic> json) {
    // Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return CampaignModel(
      id: json['id'],
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      categoryName: json['category_name'] ?? '',
      institution: json['institution'] ?? '',
      location: json['location'] ?? '',
      ongId: json['ong_id'] ?? '',
      priority: json['priority'] ?? 0.0,
      fundraisingGoal: json['fundraising_goal'] != null
          ? double.parse(json['fundraising_goal'].toString())
          : 0.0,
      fundsRaised: json['funds_raised'] != null
          ? double.parse(json['funds_raised'].toString())
          : 0.0,
      raisedPercentage: json['raised_percentage'] != null
          ? double.parse(json['raised_percentage'].toString())
          : 0,
      numberOfContributions: json['number_of_contributions'] ?? 0,
      contributionsUsers: json['contributions_users'] ?? 0,
      imageCoverUrl: json['image_cover_url'] ?? '',
      imagesUrl: List<String>.from(json['images_url'] ?? []),
      documentsUrl: List<String>.from(json['documents_url'] ?? []),
      phones: List<String>.from(json['phones'] ?? []),
      createdAt: (json['created_at'] == null)
          ? (json['created_at'] as Timestamp).toDate()
          : DateTime.now(),
      timeLeft: (json['time_left'] != null)
          ? (json['time_left'] as Timestamp).toDate()
          : DateTime.now(),
      // ong: OngModel.fromFirestore(json['ong']),
      // user: UserProfileModel.fromFirestore(json['user']),
      userId: json['user_id'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'description': description,
      'category_name': categoryName,
      'institution': institution,
      'location': location,
      'ong_id': ongId,
      'priority': priority,
      'fundraising_goal': fundraisingGoal,
      'funds_raised': fundsRaised,
      'raised_percentage': raisedPercentage,
      'number_of_contributions': numberOfContributions,
      'contributions_users': contributionsUsers,
      'image_cover_url': imageCoverUrl,
      'images_url': imagesUrl,
      'documents_url': documentsUrl,
      'phones': phones,
      'created_at': createdAt!.toIso8601String(),
      'time_left': timeLeft!.toIso8601String(),
      'ong': ong!.toFirestore(),
      'user': user!.toFirestore(),
      'user_id': userId,
    };
  }

  CampaignModel copyWith({
    String? id,
    String? title,
    String? description,
    String? categoryName,
    String? institution,
    String? location,
    String? ongId,
    int? priority,
    double? fundraisingGoal,
    double? fundsRaised,
    double? raisedPercentage,
    int? numberOfContributions,
    int? contributionsUsers,
    String? imageCoverUrl,
    List<String>? imagesUrl,
    List<String>? documentsUrl,
    List<String>? phones,
    DateTime? createdAt,
    DateTime? timeLeft,
    OngModel? ongEntity,
    UserProfileModel? user,
    String? userId,
  }) {
    return CampaignModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      categoryName: categoryName ?? this.categoryName,
      institution: institution ?? this.institution,
      location: location ?? this.location,
      ongId: ongId ?? this.ongId,
      priority: priority ?? this.priority,
      fundraisingGoal: fundraisingGoal ?? this.fundraisingGoal,
      fundsRaised: fundsRaised ?? this.fundsRaised,
      raisedPercentage: raisedPercentage ?? this.raisedPercentage,
      numberOfContributions:
          numberOfContributions ?? this.numberOfContributions,
      contributionsUsers: contributionsUsers ?? this.contributionsUsers,
      imageCoverUrl: imageCoverUrl ?? this.imageCoverUrl,
      imagesUrl: imagesUrl ?? this.imagesUrl,
      documentsUrl: documentsUrl ?? this.documentsUrl,
      phones: phones ?? this.phones,
      createdAt: createdAt ?? this.createdAt,
      timeLeft: timeLeft ?? this.timeLeft,
      ong: ongEntity ?? this.ong,
      user: user ?? this.user,
      userId: userId ?? this.userId,
    );
  }
}
