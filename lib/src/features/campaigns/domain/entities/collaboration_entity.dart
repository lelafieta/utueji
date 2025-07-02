import '../../../auth/domain/entities/user_entity.dart';
import '../../../ongs/domain/entities/ong_entity.dart';

class CollaborationEntity {
  final String? id;
  final String? campaignId;
  final String? userId;
  final String? ongId;
  final DateTime? createdAt;
  final OngEntity? ongEntity;
  final UserEntity? userEntity;

  CollaborationEntity({
    this.id,
    this.campaignId,
    this.userId,
    this.ongId,
    this.userEntity,
    this.ongEntity,
    this.createdAt,
  });
}
