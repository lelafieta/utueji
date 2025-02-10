import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../ongs/data/models/ong_model.dart';
import '../../../users/data/models/user_profile_model.dart';
import '../../domain/entities/need_entity.dart';

class NeedModel extends NeedEntity {
  NeedModel({
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

  factory NeedModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return NeedModel(
      id: doc.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      categoryName: data['category_name'] ?? '',
      institution: data['institution'] ?? '',
      location: data['location'] ?? '',
      ongId: data['ong_id'] ?? '',
      priority: data['priority'] ?? 0,
      fundraisingGoal: data['fundraising_goal'] ?? 0,
      fundsRaised: data['funds_raised'] ?? 0,
      raisedPercentage: data['raised_percentage'] ?? 0,
      numberOfContributions: data['number_of_contributions'] ?? 0,
      contributionsUsers: data['contributions_users'] ?? 0,
      imageCoverUrl: data['image_cover_url'] ?? '',
      imagesUrl: List<String>.from(data['images_url'] ?? []),
      documentsUrl: List<String>.from(data['documents_url'] ?? []),
      phones: List<String>.from(data['phones'] ?? []),
      createdAt: data['created_at'] ?? Timestamp.now(),
      timeLeft: data['time_left'] ?? Timestamp.now(),
      ong: OngModel.fromFirestore(data['ong']),
      user: UserProfileModel.fromFirestore(data['user']),
      userId: data['user_id'] ?? '',
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
      'created_at': createdAt,
      'time_left': timeLeft,
      'ong': ong!.toFirestore(),
      'user': user!.toFirestore(),
      'user_id': userId,
    };
  }

  NeedModel copyWith({
    String? id,
    String? title,
    String? description,
    String? categoryName,
    String? institution,
    String? location,
    String? ongId,
    int? priority,
    int? fundraisingGoal,
    int? fundsRaised,
    int? raisedPercentage,
    int? numberOfContributions,
    int? contributionsUsers,
    String? imageCoverUrl,
    List<String>? imagesUrl,
    List<String>? documentsUrl,
    List<String>? phones,
    Timestamp? createdAt,
    Timestamp? timeLeft,
    OngModel? ongEntity,
    UserProfileModel? user,
    String? userId,
  }) {
    return NeedModel(
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
