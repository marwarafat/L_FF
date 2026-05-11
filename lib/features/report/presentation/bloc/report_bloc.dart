import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_categories_usecase.dart';
import '../../domain/usecases/create_report_usecase.dart';
import 'report_event.dart';
import 'report_state.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  final GetCategoriesUseCase _getCategoriesUseCase;
  final CreateReportUseCase _createReportUseCase;

  ReportBloc({
    required GetCategoriesUseCase getCategoriesUseCase,
    required CreateReportUseCase createReportUseCase,
  }) : _getCategoriesUseCase = getCategoriesUseCase,
       _createReportUseCase = createReportUseCase,
       super(ReportState.initial()) {
    on<LoadCategories>(_onLoadCategories);
    on<SetLostFound>(_onSetLostFound);
    on<SetItemPeople>(_onSetItemPeople);
    on<SelectItemType>(_onSelectItemType);
    on<SelectPeopleType>(_onSelectPeopleType);
    on<SelectDate>(_onSelectDate);
    on<SetImage>(_onSetImage);
    on<SetTitle>(_onSetTitle);
    on<SetDescription>(_onSetDescription);
    on<SetLocation>(_onSetLocation);
    on<SelectSubCategory>(_onSelectSubCategory);
    on<SubmitReport>(_onSubmitReport);
  }

  Future<void> _onLoadCategories(
    LoadCategories event,
    Emitter<ReportState> emit,
  ) async {
    emit(state.copyWith(categoriesLoading: true));
    try {
      final categories = await _getCategoriesUseCase();
      emit(state.copyWith(categories: categories, categoriesLoading: false));
    } catch (_) {
      // Silently fail — dropdown will stay empty
      emit(state.copyWith(categoriesLoading: false));
    }
  }

  void _onSetLostFound(SetLostFound event, Emitter<ReportState> emit) {
    emit(state.copyWith(isLost: event.isLost, clearSelections: true));
  }

  void _onSetItemPeople(SetItemPeople event, Emitter<ReportState> emit) {
    emit(
      state.copyWith(
        isItemSelected: event.isItemSelected,
        clearSelections: true,
      ),
    );
  }

  void _onSelectItemType(SelectItemType event, Emitter<ReportState> emit) {
    emit(state.copyWith(selectedItemType: event.value));
  }

  void _onSelectPeopleType(SelectPeopleType event, Emitter<ReportState> emit) {
    emit(state.copyWith(selectedPeopleType: event.value));
  }

  void _onSelectDate(SelectDate event, Emitter<ReportState> emit) {
    emit(state.copyWith(selectedDate: event.date));
  }

  void _onSetImage(SetImage event, Emitter<ReportState> emit) {
    emit(state.copyWith(imagePath: event.imagePath));
  }

  void _onSetTitle(SetTitle event, Emitter<ReportState> emit) {
    emit(state.copyWith(title: event.title));
  }

  void _onSetDescription(SetDescription event, Emitter<ReportState> emit) {
    emit(state.copyWith(description: event.description));
  }

  void _onSetLocation(SetLocation event, Emitter<ReportState> emit) {
    emit(state.copyWith(location: event.location));
  }

  void _onSelectSubCategory(
    SelectSubCategory event,
    Emitter<ReportState> emit,
  ) {
    emit(
      state.copyWith(
        selectedSubCategoryId: event.subCategoryId,
        selectedSubCategoryName: event.subCategoryName,
      ),
    );
  }

  Future<void> _onSubmitReport(
    SubmitReport event,
    Emitter<ReportState> emit,
  ) async {
    // --- Validation ---
    if (state.title.trim().isEmpty) {
      emit(state.copyWith(errorMessage: 'Please enter a title'));
      return;
    }
    if (state.description.trim().length < 10) {
      emit(
        state.copyWith(
          errorMessage: 'Description must be at least 10 characters',
        ),
      );
      return;
    }
    if (state.selectedSubCategoryId == null) {
      emit(state.copyWith(errorMessage: 'Please select a category'));
      return;
    }

    // --- Build report type string ---
    final String reportType = _buildReportType();

    emit(state.copyWith(isSubmitting: true, clearError: true));
    try {
      await _createReportUseCase(
        title: state.title.trim(),
        description: state.description.trim(),
        type: reportType,
        subCategoryId: state.selectedSubCategoryId!,
        locationName: state.location.isNotEmpty ? state.location : null,
        dateReported: state.selectedDate,
        imagePaths: state.imagePath != null ? [state.imagePath!] : null,
      );
      emit(state.copyWith(isSubmitting: false, isSuccess: true));
    } catch (e) {
      String message = e.toString();
      if (message.startsWith('Exception: ')) message = message.substring(11);
      emit(state.copyWith(isSubmitting: false, errorMessage: message));
    }
  }

  String _buildReportType() {
    if (state.isItemSelected == true) {
      return state.isLost == true ? 'LostItem' : 'FoundItem';
    } else {
      return state.isLost == true ? 'LostPerson' : 'FoundPerson';
    }
  }
}
