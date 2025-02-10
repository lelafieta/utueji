import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../users/domain/entities/user_profile_entity.dart';

class OngEntity {
  final String? id;
  final String? name;
  final String? about;
  final List<UserProfileEntity>? admins;
  final String? bio;
  final String? coverImageUrl;
  final Timestamp? createdAt;
  final bool? isVerified;
  final String? mission;
  final List<String>? phones;
  final String? profileImageUrl;
  final int? servicesNumber;
  final int? supportesNumber;
  final String? userCreatorId;
  final String? vision;
  final UserProfileEntity? userCreator;

  OngEntity(
      {required this.id,
      required this.name,
      required this.about,
      required this.admins,
      required this.bio,
      required this.coverImageUrl,
      required this.createdAt,
      required this.isVerified,
      required this.mission,
      required this.phones,
      required this.profileImageUrl,
      required this.servicesNumber,
      required this.supportesNumber,
      required this.userCreatorId,
      required this.vision,
      required this.userCreator});
}
