import '../../../auth/data/models/user_model.dart';
import '../../../ongs/data/models/ong_model.dart';
import '../../domain/entities/feed_entity.dart';

class FeedModel extends FeedEntity {
  FeedModel({
    super.id,
    super.createdAt,
    super.userId,
    super.ongId,
    super.image,
    super.description,
    super.user,
    super.ong,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'created_at': createdAt?.toIso8601String(),
      'user_id': userId,
      'ong_id': ongId,
      'image': image,
      'description': description,
    };
  }

  factory FeedModel.fromMap(Map<String, dynamic> map) {
    return FeedModel(
      id: map['id'] ?? '',
      createdAt:
          DateTime.parse(map['created_at'] ?? DateTime.now().toIso8601String()),
      userId: map['user_id'] ?? '',
      ongId: map['ong_id'] ?? '',
      image: map['image'] ?? '',
      description: map['description'] ?? '',
      user: (map['user'] == null) ? null : UserModel.fromJson(map['user']),
      ong: (map['ong'] == null) ? null : OngModel.fromMap(map['ong']),
    );
  }
}
