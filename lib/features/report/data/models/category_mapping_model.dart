import '../../domain/entities/category_mapping_entity.dart';

class CategoryMappingModel extends CategoryMappingEntity {
  CategoryMappingModel({
    required super.category,
    required super.subCategory,
    required super.subCategoryId,
  });

  factory CategoryMappingModel.fromJson(Map<String, dynamic> json) {
    return CategoryMappingModel(
      category: json['category'] ?? '',
      subCategory: json['subCategory'] ?? '',
      subCategoryId: json['subCategoryId'] ?? 0,
    );
  }
}
