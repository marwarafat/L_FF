class ReportSummaryEntity {
  final int id;
  final String title;
  final String description;
  final String type;
  final String status;
  final String locationName;
  final String? dateReported;
  final String? imageUrl;

  ReportSummaryEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.status,
    required this.locationName,
    this.dateReported,
    this.imageUrl,
  });
}
