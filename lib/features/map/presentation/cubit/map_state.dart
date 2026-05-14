part of 'map_cubit.dart';

enum MapFilter { all, lost, found }

class MapState {
  final MapFilter selectedFilter;
  final List<RecentReportModel> allReports;
  final bool isLoading;
  final String? errorMessage;

  const MapState({
    this.selectedFilter = MapFilter.all,
    this.allReports = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  List<RecentReportModel> get filteredReports {
    switch (selectedFilter) {
      case MapFilter.all:
        return allReports
            .where((r) => r.latitude != null && r.longitude != null)
            .toList();
      case MapFilter.lost:
        return allReports
            .where((r) =>
                r.latitude != null &&
                r.longitude != null &&
                r.type == 'LostItem')
            .toList();
      case MapFilter.found:
        return allReports
            .where((r) =>
                r.latitude != null &&
                r.longitude != null &&
                r.type == 'FoundItem')
            .toList();
    }
  }

  Set<Marker> get markers {
    return filteredReports.map((r) {
      final isLost = r.type == 'LostItem';
      return Marker(
        markerId: MarkerId('report_${r.id}'),
        position: LatLng(r.latitude!, r.longitude!),
        icon: isLost
            ? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed)
            : BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        infoWindow: InfoWindow(
          title: r.title,
          snippet: '${isLost ? "Lost" : "Found"} • ${r.categoryName}',
        ),
      );
    }).toSet();
  }

  MapState copyWith({
    MapFilter? selectedFilter,
    List<RecentReportModel>? allReports,
    bool? isLoading,
    String? errorMessage,
  }) {
    return MapState(
      selectedFilter: selectedFilter ?? this.selectedFilter,
      allReports: allReports ?? this.allReports,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}
