import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../features/home/data/models/dashboard_model.dart';
import '../../../../features/home/data/repo/home_repo.dart';

part 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  final HomeRepo _homeRepo;

  MapCubit({required HomeRepo homeRepo})
      : _homeRepo = homeRepo,
        super(const MapState());

  Future<void> init() async {
    emit(state.copyWith(isLoading: true));
    try {
      final dashboard = await _homeRepo.getDashboard();
      emit(state.copyWith(
        isLoading: false,
        allReports: dashboard.recentReports,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      ));
    }
  }

  void selectFilter(MapFilter filter) {
    emit(state.copyWith(selectedFilter: filter));
  }

  Future<void> refresh() => init();
}
