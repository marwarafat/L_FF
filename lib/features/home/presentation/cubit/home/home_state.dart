// home_state.dart

part of 'home_cubit.dart';

enum HomeStatus { initial, loading, success, failure }

class HomeState {
  final HomeStatus status;

  final List<RecentReportModel> allReports;

  final List<CategoryMappingModel> categoryMapping;

  final int totalReportsCount;

  final int categoriesCount;

  final int? myReportsCount;

  final String selectedFilter;

  final String selectedCategory;

  final String searchQuery;

  final String? errorMessage;

  const HomeState({
    this.status = HomeStatus.initial,
    this.allReports = const [],
    this.categoryMapping = const [],
    this.totalReportsCount = 0,
    this.categoriesCount = 0,
    this.myReportsCount,
    this.selectedFilter = 'All',

    this.selectedCategory = 'All',

    this.searchQuery = '',
    this.errorMessage,
  });

  List<RecentReportModel> get filteredReports {
    return allReports.where((r) {
      final matchesFilter =
          selectedFilter == 'All' ||
          (selectedFilter == 'Lost' && r.type == 'LostItem') ||
          (selectedFilter == 'Found' && r.type == 'FoundItem');

      final matchesCategory =
          selectedCategory == 'All' ||
          r.categoryName.toLowerCase() == selectedCategory.toLowerCase();

      final q = searchQuery.toLowerCase();

      final matchesSearch =
          q.isEmpty ||
          r.title.toLowerCase().contains(q) ||
          r.description.toLowerCase().contains(q) ||
          (r.locationName?.toLowerCase().contains(q) ?? false);

      return matchesFilter && matchesCategory && matchesSearch;
    }).toList();
  }

  static const List<String> staticCategories = [
    'Pets',
    'Smart',
    'Emergency',
    'People',
    'Documents',
    'Accessories',
    'Electronics',
    'Other',
  ];

  List<String> get categoryNames {
    final seen = <String>{};

    final apiCategories = allReports
        .map((r) => r.categoryName)
        .where((n) => n.isNotEmpty && seen.add(n))
        .toList();

    return [
      'All',

      ...staticCategories,

      ...apiCategories,
    ].toSet().toList();
  }

  HomeState copyWith({
    HomeStatus? status,
    List<RecentReportModel>? allReports,
    List<CategoryMappingModel>? categoryMapping,
    int? totalReportsCount,
    int? categoriesCount,
    int? myReportsCount,
    String? selectedFilter,
    String? selectedCategory,
    String? searchQuery,
    String? errorMessage,
  }) {
    return HomeState(
      status: status ?? this.status,

      allReports: allReports ?? this.allReports,

      categoryMapping: categoryMapping ?? this.categoryMapping,

      totalReportsCount: totalReportsCount ?? this.totalReportsCount,

      categoriesCount: categoriesCount ?? this.categoriesCount,

      myReportsCount: myReportsCount ?? this.myReportsCount,

      selectedFilter: selectedFilter ?? this.selectedFilter,

      selectedCategory: selectedCategory ?? this.selectedCategory,

      searchQuery: searchQuery ?? this.searchQuery,

      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
