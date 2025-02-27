class FavoriteEntity {
  String? id;
  String? itemId;
  String? userId;
  String? itemType;
  DateTime? createdAt;
  DateTime? updatedAt;

  FavoriteEntity({
    this.id,
    this.itemId,
    this.userId,
    this.itemType,
    this.createdAt,
    this.updatedAt,
  });
}
