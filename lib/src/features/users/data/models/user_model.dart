import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    super.id,
    super.createdAt,
    super.updatedAt,
    super.firstName,
    super.lastName,
    super.fullName,
    super.email,
    super.avatarUrl,
    super.bio,
    super.location,
    super.isVerified,
    super.role,
    super.donationQtd,
    super.campaignQtd,
    super.phoneNumber,
  });

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      createdAt: DateTime.parse(map['created_at']),
      updatedAt:
          map['updated_at'] != null ? DateTime.parse(map['updated_at']) : null,
      firstName: map['first_name'],
      lastName: map['last_name'],
      fullName: map['full_name'],
      email: map['email'],
      avatarUrl: map['avatar_url'],
      bio: map['bio'],
      location: map['location'],
      isVerified: map['is_verified'] == 'true',
      role: map['role'],
      donationQtd: int.parse(map['donation_qtd'] ?? '0'),
      campaignQtd: int.parse(map['campaign_qtd'] ?? '0'),
      phoneNumber: map['phone_number'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'first_name': firstName,
      'last_name': lastName,
      'full_name': fullName,
      'email': email,
      'avatar_url': avatarUrl,
      'bio': bio,
      'location': location,
      'is_verified': isVerified.toString(),
      'role': role,
      'donation_qtd': donationQtd.toString(),
      'campaign_qtd': campaignQtd.toString(),
      'phone_number': phoneNumber,
    };
  }
}
