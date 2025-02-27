class FavoriteEntity {
  String? id;
  String? type; // Tipo: campanha, evento, ong, blog
  String? title;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;

  FavoriteEntity({
    this.id,
    this.type,
    this.title,
    this.description,
    this.createdAt,
    this.updatedAt,
  });
}
