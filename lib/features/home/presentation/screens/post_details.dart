// ignore_for_file: deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_styles.dart';
import '../../../../core/widgets/custom_back_button.dart';
import '../../../../core/widgets/alaa_custom_button.dart';
import '../../../../features/home/data/models/dashboard_model.dart';
import '../../../../features/home/presentation/cubit/post_details/post_details_cubit.dart';
import '../../../../features/home/presentation/screens/widgets/post_widget.dart';
import '../../../../l10n/app_localizations.dart';

class PostDetails extends StatelessWidget {
  final RecentReportModel report;

  const PostDetails({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PostDetailsCubit(),
      child: SafeArea(
        child: Scaffold(
          body: BlocConsumer<PostDetailsCubit, PostDetailsState>(
            listener: (context, state) {
              if (state.status == PostDetailsStatus.failure &&
                  state.errorMessage != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.errorMessage!),
                    backgroundColor: Colors.red,
                  ),
                );
              }
              if (state.isMarkedAsFound) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(AppLocalizations.of(context)!.marked_found_success),
                    backgroundColor: Colors.green,
                  ),
                );
              }
            },
            builder: (context, state) {
              final cubit = context.read<PostDetailsCubit>();
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        _buildHeroImage(),
                        Positioned(
                          top: 8.h,
                          left: 8.w,
                          child: CustomBackButton(
                            arrowColor: AppColors.lightGray,
                          ),
                        ),
                      ],
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 17.w,
                        vertical: 12.h,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  report.title,
                                  style: AppStyles.black25W400Style.copyWith(
                                    fontWeight: const FontWeight(800),
                                  ),
                                ),
                              ),
                              _buildBadge(
                                report.type == 'LostItem' ? AppLocalizations.of(context)!.lost : AppLocalizations.of(context)!.found,
                                report.type == 'LostItem'
                                    ? Colors.red
                                    : Colors.green,
                              ),
                              SizedBox(width: 6.w),
                              _buildBadge(
                                report.categoryName,
                                AppColors.primaryColor,
                              ),
                            ],
                          ),
                          SizedBox(height: 8.h),

                          Text(
                            report.description,
                            style: AppStyles.subTitleTextStyle.copyWith(
                              fontSize: 15.sp,
                            ),
                          ),
                          SizedBox(height: 20.h),

                          _sectionLabel(AppLocalizations.of(context)!.details),
                          SizedBox(height: 12.h),
                          _detailRow(
                            Icons.location_on_outlined,
                            report.locationName ?? AppLocalizations.of(context)!.location_not_specified,
                          ),
                          SizedBox(height: 10.h),
                          _detailRow(
                            Icons.calendar_today_outlined,
                            PostWidget.formatDateStatic(report.dateReported),
                          ),
                          SizedBox(height: 10.h),
                          _detailRow(
                            Icons.category_outlined,
                            '${report.categoryName}  ›  ${report.subCategoryName}',
                          ),

                          if (report.images.isNotEmpty) ...[
                            SizedBox(height: 20.h),
                            _sectionLabel(AppLocalizations.of(context)!.photos),
                            SizedBox(height: 10.h),
                            _buildImagesRow(),
                          ],

                          if (report.latitude != null &&
                              report.longitude != null) ...[
                            SizedBox(height: 20.h),
                            _sectionLabel(AppLocalizations.of(context)!.location_on_map),
                            SizedBox(height: 10.h),
                            _buildMap(),
                          ],

                          SizedBox(height: 20.h),
                          _sectionLabel(AppLocalizations.of(context)!.reported_by),
                          SizedBox(height: 10.h),
                          _buildReporter(context),
                          SizedBox(height: 24.h),
                          _buildActionButtons(context, cubit, state),
                          SizedBox(height: 30.h),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }


  Widget _buildHeroImage() {
    final url = report.firstImageUrl;
    return SizedBox(
      height: 260.h,
      width: double.infinity,
      child: url != null
          ? CachedNetworkImage(
              imageUrl: url,
              fit: BoxFit.cover,
              placeholder: (_, __) => Container(color: AppColors.coolGray),
              errorWidget: (_, __, ___) => _heroPlaceholder(),
            )
          : _heroPlaceholder(),
    );
  }

  Widget _heroPlaceholder() {
    return Container(
      color: AppColors.coolGray,
      child: Icon(
        Icons.image_not_supported_outlined,
        size: 60,
        color: Colors.grey[400],
      ),
    );
  }


  Widget _buildImagesRow() {
    return SizedBox(
      height: 90.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: report.images.length,
        separatorBuilder: (_, __) => SizedBox(width: 8.w),
        itemBuilder: (_, i) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: CachedNetworkImage(
              imageUrl: report.images[i].fullUrl,
              width: 90.w,
              height: 90.h,
              fit: BoxFit.cover,
              errorWidget: (_, __, ___) => Container(
                width: 90.w,
                height: 90.h,
                color: AppColors.coolGray,
                child: const Icon(Icons.broken_image_outlined),
              ),
            ),
          );
        },
      ),
    );
  }


  Widget _buildMap() {
    return Container(
      height: 160.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.lightGray, width: 1.5),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(report.latitude!, report.longitude!),
            zoom: 14,
          ),
          markers: {
            Marker(
              markerId: const MarkerId('report'),
              position: LatLng(report.latitude!, report.longitude!),
            ),
          },
          zoomControlsEnabled: false,
          myLocationButtonEnabled: false,
        ),
      ),
    );
  }


  Widget _buildReporter(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20.r),
          child: report.reporterPictureUrl != null
              ? CachedNetworkImage(
                  imageUrl: report.reporterPictureUrl!,
                  width: 48.w,
                  height: 48.h,
                  fit: BoxFit.cover,
                  errorWidget: (_, __, ___) => _defaultAvatar(),
                )
              : _defaultAvatar(),
        ),
        SizedBox(width: 12.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              report.createdByName,
              style: AppStyles.subTitleTextStyle.copyWith(
                fontWeight: const FontWeight(800),
              ),
            ),
            Text(
              AppLocalizations.of(context)!.reported_on(PostWidget.formatDateStatic(report.dateReported)),
              style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
            ),
          ],
        ),
      ],
    );
  }

  Widget _defaultAvatar() {
    return Container(
      width: 48.w,
      height: 48.h,
      color: AppColors.coolGray,
      child: Icon(Icons.person, size: 24.sp, color: Colors.grey[500]),
    );
  }


  Widget _buildActionButtons(BuildContext context, PostDetailsCubit cubit, PostDetailsState state) {
    final isLoading = state.status == PostDetailsStatus.loading;
    return Row(
      children: [
        Expanded(
          child: AlaaCustomButton(
            onPressed: isLoading ? null : cubit.contactReporter,
            width: double.infinity,
            height: 49.h,
            buttonText: AppLocalizations.of(context)!.contact,
            backgrounColor: AppColors.primaryColor,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: AlaaCustomButton(
            onPressed: isLoading || state.isMarkedAsFound
                ? null
                : cubit.markAsFound,
            width: double.infinity,
            height: 49.h,
            buttonText: state.isMarkedAsFound ? AppLocalizations.of(context)!.marked_found_btn : AppLocalizations.of(context)!.mark_found,
            backgrounColor: state.isMarkedAsFound
                ? AppColors.coolGray
                : AppColors.foundColor,
          ),
        ),
      ],
    );
  }


  Widget _sectionLabel(String label) {
    return Text(
      label,
      style: AppStyles.subTitleTextStyle.copyWith(
        fontWeight: const FontWeight(700),
        fontSize: 16.sp,
      ),
    );
  }

  Widget _detailRow(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: AppColors.primaryColor),
        SizedBox(width: 6.w),
        Expanded(
          child: Text(
            text,
            style: AppStyles.subTitleTextStyle.copyWith(
              fontWeight: const FontWeight(500),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBadge(String text, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11.sp,
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
