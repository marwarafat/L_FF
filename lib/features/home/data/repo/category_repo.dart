import '../models/category_model.dart';
import '../models/sub_category_model.dart';

abstract class CategoryRepo {
  Future<List<CategoryModel>> getCategories();

  Future<List<CategoryTreeModel>> getCategoryTree();

  Future<List<CategoryMappingModel>> getCategoryMapping();

  Future<CategoryModel> getCategoryById(int id);

  Future<List<SubCategoryModel>> getSubCategories();

  Future<List<SubCategoryModel>> getSubCategoriesByCategoryId(int categoryId);

  Future<SubCategoryModel> getSubCategoryById(int id);
}
