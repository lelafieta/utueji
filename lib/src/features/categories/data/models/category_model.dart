import '../../../../core/resources/icons/app_icons.dart';
import '../../domain/entities/category_entity.dart';

class CategoryModel extends CategoryEntity {
  CategoryModel({
    super.id,
    super.createdAt,
    super.name,
    super.iconPath,
    super.description,
  });

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'],
      name: map['name'],
      iconPath: map["icon_path"],
      description: map['description'],
      createdAt: DateTime.parse(map['created_at']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'created_at': createdAt!.toIso8601String(),
      'name': name,
      'description': description,
    };
  }
}

List<String> iconsPath = [];
List<CategoryEntity> categories = [
  CategoryEntity(
    id: "e31e98b7-6be3-43b4-af8e-ec0ac9cf0fcc",
    name: "Médico",
    description: null,
    iconPath: AppIcons.doctor,
    createdAt: DateTime.parse("2025-02-17T18:59:13.474034Z"),
  ),
  CategoryEntity(
    id: "a7408d26-8e08-49b2-b404-4855a00020b8",
    name: "Idosos",
    description: null,
    iconPath: AppIcons.oldPeople,
    createdAt: DateTime.parse("2025-02-17T18:59:13.474034Z"),
  ),
  CategoryEntity(
    id: "e949f3bd-5a94-44e0-bf6d-4728f0e9ea91",
    name: "Educação",
    description: null,
    iconPath: AppIcons.graduationCap,
    createdAt: DateTime.parse("2025-02-17T18:59:13.474034Z"),
  ),
  CategoryEntity(
    id: "ebe15c90-13d7-4ec9-8fa5-d5900cc6dcc4",
    name: "Olfã",
    description: null,
    iconPath: AppIcons.familyDress,
    createdAt: DateTime.parse("2025-02-17T18:59:13.474034Z"),
  ),
  CategoryEntity(
    id: "0279de80-27c5-4ddf-81ca-f4b5f12ec0dd",
    name: "Animal",
    description: null,
    iconPath: AppIcons.paw,
    createdAt: DateTime.parse("2025-02-17T18:59:13.474034Z"),
  ),
  CategoryEntity(
    id: "278d5de0-7b6d-4aab-9453-b587c7911aef",
    name: "Desporto",
    description: null,
    iconPath: AppIcons.tennis,
    createdAt: DateTime.parse("2025-02-17T18:59:13.474034Z"),
  ),
  CategoryEntity(
    id: "d822573c-14e5-4eca-99b4-52a35e5889b3",
    name: "Outros",
    description: null,
    iconPath: AppIcons.menuDots,
    createdAt: DateTime.parse("2025-02-17T18:59:13.474034Z"),
  ),
  CategoryEntity(
    id: "f2b24c2a-9771-4162-aa5d-8fa8a05d3cd2",
    name: "Desastre",
    description: null,
    iconPath: AppIcons.triangleWarning,
    createdAt: DateTime.parse("2025-02-17T18:59:13.474034Z"),
  ),
];
