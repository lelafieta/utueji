import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../ongs/data/models/ong_model.dart';
import '../../../users/data/models/user_profile_model.dart';

class NeedEntity {
  final String? id;
  final String? title;
  final String? description;
  final String? categoryName;
  final String? institution;
  final String? location;
  final String? ongId;
  final int? priority;
  final int? fundraisingGoal;
  final int? fundsRaised;
  final int? raisedPercentage;
  final int? numberOfContributions;
  final int? contributionsUsers;
  final String? imageCoverUrl;
  final List<String>? imagesUrl;
  final List<String>? documentsUrl;
  final List<String>? phones;
  final Timestamp? createdAt;
  final Timestamp? timeLeft;
  final OngModel? ong;
  final String? userId;
  final UserProfileModel? user;

  NeedEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.categoryName,
    required this.institution,
    required this.location,
    required this.ongId,
    required this.priority,
    required this.fundraisingGoal,
    required this.fundsRaised,
    required this.raisedPercentage,
    required this.numberOfContributions,
    required this.contributionsUsers,
    required this.imageCoverUrl,
    required this.imagesUrl,
    required this.documentsUrl,
    required this.phones,
    required this.createdAt,
    required this.timeLeft,
    required this.ong,
    required this.user,
    required this.userId,
  });
}
