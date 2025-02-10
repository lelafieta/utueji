import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/user_profile_entity.dart';

class UserProfileModel extends UserProfileEntity {
  UserProfileModel({
    super.id,
    super.name,
    super.surname,
    super.profileImageUrl,
    super.bith,
    super.createdAt,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    // Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return UserProfileModel();
    return UserProfileModel(
      id: json['id'],
      name: json['name'] ?? '',
      surname: json['surname'] ?? '',
      profileImageUrl: json['profile_image_url'] ?? '',
      bith: json['bith'] ?? Timestamp.now(),
      createdAt: json['created_at'] ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'surname': surname,
      'profile_image_url': profileImageUrl,
      'bith': bith,
      'created_at': createdAt,
    };
  }

  UserProfileModel copyWith({
    String? id,
    String? name,
    String? surname,
    String? profileImageUrl,
    Timestamp? bith,
    Timestamp? createdAt,
  }) {
    return UserProfileModel(
      id: id ?? this.id,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      bith: bith ?? this.bith,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
