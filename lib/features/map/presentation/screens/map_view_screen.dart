import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_styles.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/widgets/category_container.dart';
import '../../../../features/map/presentation/cubit/map_cubit.dart';
import '../../../../l10n/app_localizations.dart';

class MapViewScreen extends StatelessWidget {
  const MapViewScreen({super.key});

  static const _cairo = LatLng(30.0444, 31.2357);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MapCubit(homeRepo: sl())..init(),
      child: BlocBuilder<MapCubit, MapState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(18.w),
            child: Column(
              children: [
                SizedBox(height: 15.h),
                _buildHeader(context),
                SizedBox(height: 19.h),
                _buildFilterRow(context, state),
                SizedBox(height: 10.h),
                _buildLegend(context),
                SizedBox(height: 8.h),
                Expanded(child: _buildMap(context, state)),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        Text(
          AppLocalizations.of(context)!.map_view,
          style: AppStyles.subTitleTextStyle.copyWith(
            fontWeight: FontWeight.w800,
            fontSize: 20.sp,
          ),
        ),
      ],
    );
  }

  Widget _buildFilterRow(BuildContext context, MapState state) {
    final filters = [
      (MapFilter.all, AppLocalizations.of(context)!.all),
      (MapFilter.lost, AppLocalizations.of(context)!.lost),
      (MapFilter.found, AppLocalizations.of(context)!.found),
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: filters.map((f) {
        final isSelected = state.selectedFilter == f.$1;
        Color color = AppColors.primaryColor;
        if (f.$1 == MapFilter.lost) color = Colors.red;
        if (f.$1 == MapFilter.found) color = Colors.green;

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.w),
          child: GestureDetector(
            onTap: () => context.read<MapCubit>().selectFilter(f.$1),
            child: CategoryContainer(
              width: f.$2 == AppLocalizations.of(context)!.all ? 70.w : 86.w,
              height: 39.h,
              containerText: f.$2,
              backgroundColor: isSelected ? color : AppColors.coolGray,
              containerTextColor: isSelected ? Colors.white : Colors.black,
              containerTextFontSize: 15.sp,
              containerTextFontWeight: FontWeight.w500,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildLegend(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _legendDot(Colors.red),
        SizedBox(width: 4.w),
        Text(AppLocalizations.of(context)!.lost, style: TextStyle(fontSize: 12.sp)),
        SizedBox(width: 16.w),
        _legendDot(Colors.green),
        SizedBox(width: 4.w),
        Text(AppLocalizations.of(context)!.found, style: TextStyle(fontSize: 12.sp)),
      ],
    );
  }

  Widget _legendDot(Color color) {
    return Container(
      width: 12.w,
      height: 12.h,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }

  Widget _buildMap(BuildContext context, MapState state) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.errorMessage != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 40),
            SizedBox(height: 8.h),
            Text(state.errorMessage!),
            SizedBox(height: 8.h),
            ElevatedButton(
              onPressed: () => context.read<MapCubit>().refresh(),
              child: Text(AppLocalizations.of(context)!.retry),
            ),
          ],
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.lightGray, width: 2),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.r),
        child: GoogleMap(
          initialCameraPosition: const CameraPosition(
            target: _cairo,
            zoom: 11,
          ),
          markers: state.markers,
          zoomControlsEnabled: true,
          myLocationButtonEnabled: false,
          mapToolbarEnabled: false,
        ),
      ),
    );
  }
}
