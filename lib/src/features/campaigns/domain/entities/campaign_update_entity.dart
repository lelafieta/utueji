class CampaignUpdateEntity {
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? title;
  final String? description;

  CampaignUpdateEntity({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.title,
    this.description,
  });

  factory CampaignUpdateEntity.fromJson(Map<String, dynamic> json) {
    return CampaignUpdateEntity(
      id: json['id'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      title: json['title'] as String?,
      description: json['description'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'title': title,
      'description': description,
    };
  }
}
