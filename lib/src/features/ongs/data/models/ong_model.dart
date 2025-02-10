import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../users/data/models/user_profile_model.dart';
import '../../domain/entities/ong_entity.dart';

class OngModel extends OngEntity {
  OngModel({
    super.id,
    super.name,
    super.about,
    super.admins,
    super.bio,
    super.coverImageUrl,
    super.createdAt,
    super.isVerified,
    super.mission,
    super.phones,
    super.profileImageUrl,
    super.servicesNumber,
    super.supportesNumber,
    super.userCreatorId,
    super.vision,
    super.userCreator,
  });
  factory OngModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return OngModel(
      id: doc.id,
      name: data['name'] ?? '',
      about: data['about'] ?? '',
      admins: (data['admins'] as List<dynamic>?)
              ?.map((admin) => UserProfileModel.fromJson(admin))
              .toList() ??
          [],
      bio: data['bio'] ?? '',
      coverImageUrl: data['cover_image_url'] ?? '',
      createdAt: data['created_at'] ?? Timestamp.now(),
      isVerified: data['is_verified'] ?? false,
      mission: data['mission'] ?? '',
      phones: List<String>.from(data['phones'] ?? []),
      profileImageUrl: data['profile_image_url'] ?? '',
      servicesNumber: data['services_number'] ?? 0,
      supportesNumber: data['supportes_number'] ?? 0,
      userCreatorId: data['user_creator_id'] ?? '',
      vision: data['vision'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'about': about,
      'admins': admins,
      'bio': bio,
      'cover_image_url': coverImageUrl,
      'created_at': createdAt,
      'is_verify': isVerified,
      'mission': mission,
      'phones': phones,
      'profile_image_url': profileImageUrl,
      'services_number': servicesNumber,
      'supportes_number': supportesNumber,
      'user_creator_id': userCreatorId,
      'vision': vision,
    };
  }

  OngModel copyWith({
    String? id,
    String? name,
    String? about,
    List<UserProfileModel>? admins,
    String? bio,
    String? coverImageUrl,
    Timestamp? createdAt,
    bool? isVerified,
    String? mission,
    List<String>? phones,
    String? profileImageUrl,
    int? servicesNumber,
    int? supportesNumber,
    String? userCreatorId,
    String? vision,
  }) {
    return OngModel(
      id: id ?? this.id,
      name: name ?? this.name,
      about: about ?? this.about,
      admins: admins ?? this.admins,
      bio: bio ?? this.bio,
      coverImageUrl: coverImageUrl ?? this.coverImageUrl,
      createdAt: createdAt ?? this.createdAt,
      isVerified: isVerified ?? this.isVerified,
      mission: mission ?? this.mission,
      phones: phones ?? this.phones,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      servicesNumber: servicesNumber ?? this.servicesNumber,
      supportesNumber: supportesNumber ?? this.supportesNumber,
      userCreatorId: userCreatorId ?? this.userCreatorId,
      vision: vision ?? this.vision,
    );
  }
}
