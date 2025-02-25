class CommunityEntity {
  final String? id;
  final String? userId;
  final String? name;
  final String? description;
  final String? image;
  final String? banner;
  final DateTime? createdAt;

  CommunityEntity({
    this.id,
    this.userId,
    this.name,
    this.image,
    this.banner,
    this.description,
    this.createdAt,
  });
}
