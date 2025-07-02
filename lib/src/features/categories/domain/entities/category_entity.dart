class CategoryEntity {
  String? id;
  String? name;
  String? description;
  String? iconPath;
  DateTime? createdAt;

  CategoryEntity({
    this.id,
    this.createdAt,
    this.name,
    this.iconPath,
    this.description,
  });
}
