import '../entities/category_mapping_entity.dart';
import '../repositories/report_repository.dart';

class GetCategoriesUseCase {
  final ReportRepository repository;

  GetCategoriesUseCase(this.repository);

  Future<List<CategoryMappingEntity>> call() async {
    return await repository.getCategoryMapping();
  }
}
