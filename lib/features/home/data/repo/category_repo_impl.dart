import '../../../../core/networking/dio_consumer.dart';
import '../models/category_model.dart';
import '../models/sub_category_model.dart';
import 'category_repo.dart';

class CategoryRepoImpl implements CategoryRepo {
  final DioConsumer _dio;

  CategoryRepoImpl(this._dio);

  List<T> _parseList<T>(
    dynamic response,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    final body = response as Map<String, dynamic>;
    final raw = body['data'] as List<dynamic>? ?? [];
    return raw.map((e) => fromJson(e as Map<String, dynamic>)).toList();
  }

  T _parseSingle<T>(
    dynamic response,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    final body = response as Map<String, dynamic>;
    return fromJson(body['data'] as Map<String, dynamic>);
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    final response = await _dio.get('categories');
    return _parseList(response, CategoryModel.fromJson);
  }

  @override
  Future<List<CategoryTreeModel>> getCategoryTree() async {
    final response = await _dio.get('categories/tree');
    return _parseList(response, CategoryTreeModel.fromJson);
  }

  @override
  Future<List<CategoryMappingModel>> getCategoryMapping() async {
    final response = await _dio.get('categories/mapping');
    return _parseList(response, CategoryMappingModel.fromJson);
  }

  @override
  Future<CategoryModel> getCategoryById(int id) async {
    final response = await _dio.get('categories/$id');
    return _parseSingle(response, CategoryModel.fromJson);
  }

  @override
  Future<List<SubCategoryModel>> getSubCategories() async {
    final response = await _dio.get('subcategories');
    return _parseList(response, SubCategoryModel.fromJson);
  }

  @override
  Future<List<SubCategoryModel>> getSubCategoriesByCategoryId(int categoryId) async {
    final response = await _dio.get('subcategories/category/$categoryId');
    return _parseList(response, SubCategoryModel.fromJson);
  }

  @override
  Future<SubCategoryModel> getSubCategoryById(int id) async {
    final response = await _dio.get('subcategories/$id');
    return _parseSingle(response, SubCategoryModel.fromJson);
  }
}
