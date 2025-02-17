import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
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

  const UserEntity({
    required this.id,
    required this.fullName,
    required this.email,
    this.avatarUrl,
    this.phoneNumber,
    this.bio,
    required this.createdAt,
    required this.updatedAt,
    this.location,
    required this.isVerified,
    required this.role,
  });

  @override
  List<Object?> get props => [
        id,
        fullName,
        email,
        avatarUrl,
        phoneNumber,
        bio,
        createdAt,
        updatedAt,
        location,
        isVerified,
        role,
      ];
}
