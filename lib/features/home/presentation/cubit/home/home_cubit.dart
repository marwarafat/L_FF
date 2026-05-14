// home_cubit.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../features/home/data/models/category_model.dart';
import '../../../../../features/home/data/models/dashboard_model.dart';
import '../../../../../features/home/data/repo/category_repo.dart';
import '../../../../../features/home/data/repo/home_repo.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepo _homeRepo;
  final CategoryRepo _categoryRepo;

  HomeCubit({
    required HomeRepo homeRepo,
    required CategoryRepo categoryRepo,
  })  : _homeRepo = homeRepo,
        _categoryRepo = categoryRepo,
        super(const HomeState());

  Future<void> init() async {
    emit(
      state.copyWith(
        status: HomeStatus.loading,
      ),
    );

    try {

      final results = await Future.wait([
        _homeRepo.getDashboard(),
        _categoryRepo.getCategoryMapping(),
      ]);

      final dashboard =
          results[0] as DashboardModel;

      final mapping =
          results[1]
              as List<CategoryMappingModel>;

      emit(
        state.copyWith(
          status: HomeStatus.success,

          allReports:
              dashboard.recentReports,

          categoryMapping: mapping,

          totalReportsCount:
              dashboard.totalReportsCount,

          categoriesCount:
              dashboard.categoriesCount,

          myReportsCount:
              dashboard.myReportsCount,
        ),
      );

    } catch (e) {

      emit(
        state.copyWith(
          status: HomeStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void selectFilter(String filter) {

    emit(
      state.copyWith(
        selectedFilter: filter,
      ),
    );
  }

  void selectCategory(String category) {

    emit(
      state.copyWith(
        selectedCategory: category,
      ),
    );
  }

  void updateSearch(String query) {

    emit(
      state.copyWith(
        searchQuery: query,
      ),
    );
  }

  Future<void> refresh() => init();
}
