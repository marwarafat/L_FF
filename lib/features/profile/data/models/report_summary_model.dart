import '../../domain/entities/report_summary_entity.dart';

class ReportSummaryModel extends ReportSummaryEntity {
  ReportSummaryModel({
    required super.id,
    required super.title,
    required super.description,
    required super.type,
    required super.status,
    required super.locationName,
    super.dateReported,
    super.imageUrl,
  });

  factory ReportSummaryModel.fromJson(Map<String, dynamic> json) {
    String? imgUrl;
    if (json['images'] != null &&
        json['images'] is List &&
        json['images'].isNotEmpty) {
      var firstImage = json['images'][0];
      if (firstImage is Map) {
        imgUrl = firstImage['imageUrl'];
      } else if (firstImage is String) {
        imgUrl = firstImage;
      }
    }

    return ReportSummaryModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      type: json['type'] ?? '',
      status: json['status'] ?? '',
      locationName: json['locationName'] ?? '',
      dateReported: json['dateReported'],
      imageUrl: imgUrl,
    );
  }
}
