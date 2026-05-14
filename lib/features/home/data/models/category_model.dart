import 'sub_category_model.dart';

class CategoryModel {
  final int id;
  final String name;
  final String description;
  final int subCategoryCount;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const CategoryModel({
    required this.id,
    required this.name,
    required this.description,
    required this.subCategoryCount,
    this.createdAt,
    this.updatedAt,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String? ?? '',
      subCategoryCount: json['subCategoryCount'] as int? ?? 0,
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
        'subCategoryCount': subCategoryCount,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
      };
}

class CategoryTreeModel {
  final int id;
  final String name;
  final String description;
  final List<SubCategoryModel> subCategories;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const CategoryTreeModel({
    required this.id,
    required this.name,
    required this.description,
    required this.subCategories,
    this.createdAt,
    this.updatedAt,
  });

  factory CategoryTreeModel.fromJson(Map<String, dynamic> json) {
    final rawSubs = json['subCategories'] as List<dynamic>? ?? [];
    return CategoryTreeModel(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String? ?? '',
      subCategories: rawSubs
          .map((e) => SubCategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'] as String)
          : null,
    );
  }
}

class CategoryMappingModel {
  final String category;
  final String subCategory;
  final int subCategoryId;

  const CategoryMappingModel({
    required this.category,
    required this.subCategory,
    required this.subCategoryId,
  });

  factory CategoryMappingModel.fromJson(Map<String, dynamic> json) {
    return CategoryMappingModel(
      category: json['category'] as String,
      subCategory: json['subCategory'] as String,
      subCategoryId: json['subCategoryId'] as int,
    );
  }
}
