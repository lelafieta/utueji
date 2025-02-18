import '../../../auth/data/models/user_model.dart';
import '../../../categories/data/models/category_model.dart';
import '../../../ongs/data/models/ong_model.dart';
import '../../domain/entities/campaign_entity.dart';

class CampaignModel extends CampaignEntity {
  CampaignModel({
    super.id,
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
    super.phoneNumber,
    super.priority = 0,
    super.endDate,
    super.title,
    super.userId,
    super.startDate,
    super.category,
    super.ong,
    super.user,
  });

  factory CampaignModel.fromJson(Map<String, dynamic> map) {
    print("======================");
    print(map["category"]);
    return CampaignModel(
        id: map['id'],
        createdAt: DateTime.parse(map['created_at']),
        updatedAt: map['updated_at'] != null
            ? DateTime.parse(map['updated_at'])
            : null,
        categoryId: map['category_id'],
        description: map['description'],
        fundraisingGoal: map['fundraising_goal']?.toDouble(),
        fundsRaised: map['funds_raised']?.toDouble(),
        imageCoverUrl: map['image_cover_url'],
        institution: map['institution'],
        location: map['location'],
        numberOfContributions: map['number_of_contributions'],
        ongId: map['ong_id'],
        phoneNumber: map['phone_number'],
        priority: map['priority'] ?? 0,
        endDate:
            map['end_date'] != null ? DateTime.parse(map['end_date']) : null,
        title: map['title'],
        userId: map['user_id'],
        startDate: map['start_date'] != null
            ? DateTime.parse(map['start_date'])
            : null,
        category: CategoryModel.fromMap(map['category']),
        ong: OngModel.fromMap(map['ong']),
        user: UserModel.fromJson(map['user']));
  }

  // Method to convert the CampaignModel to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'created_at': createdAt!.toIso8601String(),
      'updated_at': updatedAt!.toIso8601String(),
      'category_id': categoryId,
      'description': description,
      'fundraising_goal': fundraisingGoal,
      'funds_raised': fundsRaised,
      'image_cover_url': imageCoverUrl,
      'institution': institution,
      'location': location,
      'number_of_contributions': numberOfContributions,
      'ong_id': ongId,
      'phone_number': phoneNumber,
      'priority': priority,
      'end_date': endDate?.toIso8601String(),
      'title': title,
      'user_id': userId,
      'start_date': startDate?.toIso8601String(),
    };
  }
}
