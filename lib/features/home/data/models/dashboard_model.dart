import '../../../../core/networking/api_constants.dart';

class ReportImageModel {
  final int id;
  final String imageUrl;
  final int reportId;

  const ReportImageModel({
    required this.id,
    required this.imageUrl,
    required this.reportId,
  });

  factory ReportImageModel.fromJson(Map<String, dynamic> json) {
    return ReportImageModel(
      id: json['id'] as int,
      imageUrl: json['imageUrl'] as String? ?? '',
      reportId: json['reportId'] as int? ?? 0,
    );
  }

  String get fullUrl => '${ApiConstants.baseDomain}$imageUrl';
}

class RecentReportModel {
  final int id;
  final String title;
  final String description;
  final String type;            
  final String status;         
  final String lifecycleStatus; 
  final String? locationName;
  final double? latitude;
  final double? longitude;
  final int subCategoryId;
  final String subCategoryName;
  final String categoryName;
  final int createdById;
  final String createdByName;
  final String? createdByProfilePictureUrl;
  final String dateReported;
  final String createdAt;
  final List<ReportImageModel> images;

  const RecentReportModel({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.status,
    required this.lifecycleStatus,
    this.locationName,
    this.latitude,
    this.longitude,
    required this.subCategoryId,
    required this.subCategoryName,
    required this.categoryName,
    required this.createdById,
    required this.createdByName,
    this.createdByProfilePictureUrl,
    required this.dateReported,
    required this.createdAt,
    required this.images,
  });

  String? get firstImageUrl =>
      images.isNotEmpty ? images.first.fullUrl : null;

  String? get reporterPictureUrl => createdByProfilePictureUrl != null
      ? '${ApiConstants.baseDomain}$createdByProfilePictureUrl'
      : null;

  factory RecentReportModel.fromJson(Map<String, dynamic> json) {
    final rawImages = json['images'] as List<dynamic>? ?? [];
    return RecentReportModel(
      id: json['id'] as int,
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      type: json['type'] as String? ?? '',
      status: json['status'] as String? ?? '',
      lifecycleStatus: json['lifecycleStatus'] as String? ?? '',
      locationName: json['locationName'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      subCategoryId: json['subCategoryId'] as int? ?? 0,
      subCategoryName: json['subCategoryName'] as String? ?? '',
      categoryName: json['categoryName'] as String? ?? '',
      createdById: json['createdById'] as int? ?? 0,
      createdByName: json['createdByName'] as String? ?? '',
      createdByProfilePictureUrl:
          json['createdByProfilePictureUrl'] as String?,
      dateReported: json['dateReported'] as String? ?? '',
      createdAt: json['createdAt'] as String? ?? '',
      images: rawImages
          .map((e) => ReportImageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class DashboardModel {
  final List<RecentReportModel> recentReports;
  final int totalReportsCount;
  final int categoriesCount;
  final int? myReportsCount;

  const DashboardModel({
    required this.recentReports,
    required this.totalReportsCount,
    required this.categoriesCount,
    this.myReportsCount,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    final rawReports = json['recentReports'] as List<dynamic>? ?? [];
    return DashboardModel(
      recentReports: rawReports
          .map((e) => RecentReportModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalReportsCount: json['totalReportsCount'] as int? ?? 0,
      categoriesCount: json['categoriesCount'] as int? ?? 0,
      myReportsCount: json['myReportsCount'] as int?,
    );
  }
}
