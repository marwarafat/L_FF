import 'package:equatable/equatable.dart';
import '../../domain/entities/category_mapping_entity.dart';

class ReportState extends Equatable {
  // UI toggles
  final bool? isLost;
  final bool? isItemSelected;
  final String? selectedItemType;
  final String? selectedPeopleType;
  final DateTime? selectedDate;
  final String? imagePath;

  // Form fields
  final String title;
  final String description;
  final String location;
  final int? selectedSubCategoryId;
  final String? selectedSubCategoryName;

  // API categories
  final List<CategoryMappingEntity> categories;
  final bool categoriesLoading;

  // Submission
  final bool isSubmitting;
  final bool isSuccess;
  final String? errorMessage;

  const ReportState({
    this.isLost,
    this.isItemSelected,
    this.selectedItemType,
    this.selectedPeopleType,
    this.selectedDate,
    this.imagePath,
    this.title = '',
    this.description = '',
    this.location = '',
    this.selectedSubCategoryId,
    this.selectedSubCategoryName,
    this.categories = const [],
    this.categoriesLoading = false,
    this.isSubmitting = false,
    this.isSuccess = false,
    this.errorMessage,
  });

  factory ReportState.initial() => const ReportState();

  ReportState copyWith({
    bool? isLost,
    bool? isItemSelected,
    String? selectedItemType,
    String? selectedPeopleType,
    DateTime? selectedDate,
    String? imagePath,
    String? title,
    String? description,
    String? location,
    int? selectedSubCategoryId,
    String? selectedSubCategoryName,
    List<CategoryMappingEntity>? categories,
    bool? categoriesLoading,
    bool? isSubmitting,
    bool? isSuccess,
    String? errorMessage,
    bool clearError = false,
    bool clearSelections = false,
  }) {
    return ReportState(
      isLost: isLost ?? this.isLost,
      isItemSelected: isItemSelected ?? this.isItemSelected,
      selectedItemType: clearSelections ? null : (selectedItemType ?? this.selectedItemType),
      selectedPeopleType: clearSelections ? null : (selectedPeopleType ?? this.selectedPeopleType),
      selectedDate: selectedDate ?? this.selectedDate,
      imagePath: imagePath ?? this.imagePath,
      title: title ?? this.title,
      description: description ?? this.description,
      location: location ?? this.location,
      selectedSubCategoryId: clearSelections ? null : (selectedSubCategoryId ?? this.selectedSubCategoryId),
      selectedSubCategoryName: clearSelections ? null : (selectedSubCategoryName ?? this.selectedSubCategoryName),
      categories: categories ?? this.categories,
      categoriesLoading: categoriesLoading ?? this.categoriesLoading,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? false,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  /// Returns filtered subcategories based on current toggle selections
  List<CategoryMappingEntity> get filteredSubCategories {
    if (isItemSelected == null) return [];

    bool isPerson(CategoryMappingEntity c) {
      final cat = c.category.toLowerCase();
      final sub = c.subCategory.toLowerCase();
      return cat.contains('person') ||
          cat.contains('people') ||
          sub.contains('person') ||
          sub.contains('people');
    }

    if (isItemSelected == true) {
      // Items — Everything that is NOT a person
      return categories.where((c) => !isPerson(c)).toList();
    } else {
      // People — Only categories or subcategories related to people
      return categories.where((c) => isPerson(c)).toList();
    }
  }

  @override
  List<Object?> get props => [
        isLost,
        isItemSelected,
        selectedItemType,
        selectedPeopleType,
        selectedDate,
        imagePath,
        title,
        description,
        location,
        selectedSubCategoryId,
        selectedSubCategoryName,
        categories,
        categoriesLoading,
        isSubmitting,
        isSuccess,
        errorMessage,
      ];
}
