import 'package:utueji/src/features/ongs/data/models/ong_document_model.dart';

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
    super.email,
    super.website,
    super.phoneNumber,
    super.profileImageUrl,
    super.servicesNumber,
    super.supportsNumber,
    super.userId,
    super.vision,
    super.ongDocument,
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
      email: map['email'],
      status: map['status'],
      website: map['website'],
      phoneNumber: map['phone_number'],
      profileImageUrl: map['profile_image_url'],
      servicesNumber: map['services_number'],
      supportsNumber: map['supports_number']?.toDouble(),
      userId: map['user_id'],
      vision: map['vision'],
      ongDocument: (map['ong_document'] != null)
          ? OngDocumentModel.fromMap(map['ong_document'])
          : map['ong_document'],
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
      'email': email,
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
