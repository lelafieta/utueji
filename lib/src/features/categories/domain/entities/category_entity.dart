import 'package:flutter/material.dart';

class CategoryEntity {
  String? id;
  String? name;
  String? description;
  String? iconPath;
  Color? color;
  DateTime? createdAt;

  CategoryEntity({
    this.id,
    this.createdAt,
    this.name,
    this.iconPath,
    this.color,
    this.description,
  });
}
