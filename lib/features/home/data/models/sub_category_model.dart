class SubCategoryModel {
  final int id;
  final String name;
  final String description;
  final int categoryId;
  final String categoryName;
  final int reportCount;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const SubCategoryModel({
    required this.id,
    required this.name,
    required this.description,
    required this.categoryId,
    required this.categoryName,
    required this.reportCount,
    this.createdAt,
    this.updatedAt,
  });

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) {
    return SubCategoryModel(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String? ?? '',
      categoryId: json['categoryId'] as int,
      categoryName: json['categoryName'] as String? ?? '',
      reportCount: json['reportCount'] as int? ?? 0,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'categoryId': categoryId,
        'categoryName': categoryName,
        'reportCount': reportCount,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
      };
}
