class CampaignParams {
  final int page;
  final int limit;
  final String? categoryId;
  final String? nameFilter;
  final String? status;
  final String? location;
  final DateTime? startDate;
  final DateTime? endDate;

  CampaignParams({
    required this.page,
    required this.limit,
    this.categoryId,
    this.nameFilter,
    this.status,
    this.location,
    this.startDate,
    this.endDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'limit': limit,
      if (categoryId != null) 'category_id': categoryId,
      if (nameFilter != null) 'name': nameFilter,
      if (status != null) 'status': status,
      if (location != null) 'location': location,
      if (startDate != null) 'start_date': startDate!.toIso8601String(),
      if (endDate != null) 'end_date': endDate!.toIso8601String(),
    };
  }
}
