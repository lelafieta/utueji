import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfileEntity {
  final String? id;
  final String? name;
  final String? surname;
  final String? profileImageUrl;
  final Timestamp? bith;
  final Timestamp? createdAt;

  UserProfileEntity({
    required this.id,
    required this.name,
    required this.surname,
    required this.profileImageUrl,
    required this.bith,
    required this.createdAt,
  });
}
