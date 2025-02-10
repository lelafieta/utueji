import '../../domain/entities/user_profile_entity.dart';

class UserProfileModel extends UserProfileEntity {
  UserProfileModel({
    super.id,
    super.name,
  });

  factory UserProfileModel.fromFirestore(Map<String, dynamic> data) {
    return UserProfileModel(
      id: data['id'] ?? '',
      name: data['name'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
    };
  }

  UserProfileModel copyWith({
    String? id,
    String? name,
  }) {
    return UserProfileModel(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}
