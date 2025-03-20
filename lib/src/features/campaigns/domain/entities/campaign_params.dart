class CampaignParams {
  int? page;
  int? limit;
  String? title;
  String? description;
  String? categoryId;
  String? nameFilter;
  String? status;
  String? location;
  String? filter;
  DateTime? startDate;
  DateTime? endDate;

  CampaignParams({
    this.page,
    this.limit,
    this.title,
    this.description,
    this.categoryId,
    this.nameFilter,
    this.filter,
    this.status,
    this.location,
    this.startDate,
    this.endDate,
  });

  CampaignParams copyWith({
    int? page,
    int? limit,
    String? title,
    String? description,
    String? categoryId,
    String? nameFilter,
    String? status,
    String? location,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return CampaignParams(
      page: page ?? this.page,
      limit: limit ?? this.limit,
      title: title ?? this.title,
      description: description ?? this.description,
      categoryId: categoryId ?? this.categoryId,
      nameFilter: nameFilter ?? this.nameFilter,
      status: status ?? this.status,
      location: location ?? this.location,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }

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
