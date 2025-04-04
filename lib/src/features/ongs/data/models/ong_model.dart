import '../../domain/entities/ong_entity.dart';

class OngModel extends OngEntity {
  OngModel({
    super.id,
    super.createdAt,
    super.updatedAt,
    super.about,
    super.bio,
    super.coverImageUrl,
    super.isVerified,
    super.status,
    super.mission,
    super.name,
    super.phoneNumber,
    super.profileImageUrl,
    super.servicesNumber,
    super.supportsNumber,
    super.userId,
    super.vision,
  });

  factory OngModel.fromMap(Map<String, dynamic> map) {
    return OngModel(
      id: map['id'],
      createdAt: DateTime.parse(map['created_at']),
      updatedAt:
          map['updated_at'] != null ? DateTime.parse(map['updated_at']) : null,
      about: map['about'],
      bio: map['bio'],
      coverImageUrl: map['cover_image_url'],
      isVerified: map['is_verified'] == true,
      mission: map['mission'],
      name: map['name'],
      status: map['status'],
      phoneNumber: map['phone_number'],
      profileImageUrl: map['profile_image_url'],
      servicesNumber: map['services_number'],
      supportsNumber: map['supports_number']?.toDouble(),
      userId: map['user_id'],
      vision: map['vision'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'about': about,
      'bio': bio,
      'cover_image_url': coverImageUrl,
      'is_verified': isVerified,
      'mission': mission,
      'name': name,
      'phone_number': phoneNumber,
      'profile_image_url': profileImageUrl,
      'services_number': servicesNumber,
      'supports_number': supportsNumber,
      'user_id': userId,
      'status': status,
      'vision': vision,
    };
  }
}
