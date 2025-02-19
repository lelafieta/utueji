import '../../../auth/domain/entities/user_entity.dart';
import '../../../ongs/domain/entities/ong_entity.dart';

class FeedEntity {
  final String? id;
  final DateTime? createdAt;
  final String? userId;
  final String? ongId;
  final String? image;
  final String? description;
  final UserEntity? user;
  final OngEntity? ong;

  FeedEntity({
    this.id,
    this.createdAt,
    this.userId,
    this.ongId,
    this.image,
    this.description,
    this.user,
    this.ong,
  });
}
