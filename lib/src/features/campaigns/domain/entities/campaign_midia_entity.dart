class CampaignMidiaEntity {
  final String? id;
  final String? userId;
  final String? midiaUrl;
  final String? midiaType;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  CampaignMidiaEntity(
      {this.id,
      this.midiaType,
      this.createdAt,
      this.updatedAt,
      this.midiaUrl,
      this.userId});
}
