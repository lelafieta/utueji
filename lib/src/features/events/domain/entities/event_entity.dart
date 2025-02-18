class EventEntity {
  final String? id;
  final DateTime? createdAt;
  final String? ongId;
  final String? userId;
  final String? title;
  final String? location;
  final String? description;
  final String? backgroundImageUrl;
  final DateTime? startDate;
  final DateTime? endDate;
  final DateTime? updatedAt;

  EventEntity({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.ongId,
    this.userId,
    this.title,
    this.location,
    this.description,
    this.backgroundImageUrl,
    this.startDate,
    this.endDate,
  });
}
