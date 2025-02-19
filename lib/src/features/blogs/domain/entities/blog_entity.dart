import '../../../auth/domain/entities/user_entity.dart';
import '../../../ongs/domain/entities/ong_entity.dart';

class BlogEntity {
  final String id;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String title;
  final String description;
  final String userId;
  final String ondId;
  final String? image;
  final UserEntity? user;
  final OngEntity? ong;

  BlogEntity(
      {required this.id,
      required this.createdAt,
      this.updatedAt,
      required this.title,
      required this.description,
      required this.userId,
      required this.ondId,
      this.image,
      this.user,
      this.ong});
}
