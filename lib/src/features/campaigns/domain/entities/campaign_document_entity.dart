class CampaignDocumentEntity {
  final String? id;
  final String? userId;
  final String? documentPath;
  final bool? isApproved;
  final String? campaignId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  CampaignDocumentEntity(
      {this.id,
      this.isApproved,
      this.createdAt,
      this.updatedAt,
      this.campaignId,
      this.documentPath,
      this.userId});
}
