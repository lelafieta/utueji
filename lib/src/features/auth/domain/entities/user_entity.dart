import 'user_fcm_token_entity.dart';

class UserEntity {
  final String? id;
  final String? fullName;
  final String? email;
  final String? avatarUrl;
  final String? phoneNumber;
  final String? bio;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? location;
  final bool? isVerified;
  final String? role;
  final String? firstName;
  final String? lastName;
  final UserFcmTokenEntity? userFcmTokenEntity;

  const UserEntity(
      {this.id,
      this.fullName,
      this.lastName,
      this.firstName,
      this.email,
      this.avatarUrl,
      this.phoneNumber,
      this.bio,
      this.createdAt,
      this.updatedAt,
      this.location,
      this.isVerified,
      this.role,
      this.userFcmTokenEntity});
}
