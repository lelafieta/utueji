import '../../domain/entities/favorite_entity.dart';

class FavoriteModel extends FavoriteEntity {
  FavoriteModel({
    super.id,
    super.itemId,
    super.itemType,
    super.userId,
    super.createdAt,
    super.updatedAt,
  });
  Map<String, dynamic> toMap() {
    return {
      'item_id': itemId,
      'user_id': userId,
      'item_type': itemType,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  /// Construtor para criar um objeto a partir de um Map
  factory FavoriteModel.fromJson(Map<String, dynamic> map) {
    return FavoriteModel(
      id: map['id'],
      itemId: map['item_id'],
      userId: map['useri_d'],
      itemType: map['item_type'],
      createdAt:
          map['created_at'] != null ? DateTime.parse(map['created_at']) : null,
      updatedAt:
          map['updated_at'] != null ? DateTime.parse(map['updated_at']) : null,
    );
  }

  factory FavoriteModel.fromEntity(FavoriteEntity entity) {
    return FavoriteModel(
      id: entity.id,
      itemId: entity.itemId,
      userId: entity.userId,
      itemType: entity.itemType,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }
}
