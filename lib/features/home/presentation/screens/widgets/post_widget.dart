// ignore_for_file: deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_styles.dart';
import '../../../../../features/home/data/models/dashboard_model.dart';

class PostWidget extends StatelessWidget {
  final String postTitle;
  final String postDescription;
  final String? postImageUrl;  
  final String location;
  final String date;
  final String reporterName;
  final String? reporterImageUrl;
  final String postType;       
  final String postCategory;   
  const PostWidget({
    super.key,
    required this.postTitle,
    required this.postDescription,
    this.postImageUrl,
    required this.location,
    required this.date,
    required this.reporterName,
    this.reporterImageUrl,
    required this.postType,
    required this.postCategory,
  });

  factory PostWidget.fromReport(RecentReportModel r) {
    return PostWidget(
      postTitle: r.title,
      postDescription: r.description,
      postImageUrl: r.firstImageUrl,
      location: r.locationName ?? 'Location not specified',
      date: PostWidget.formatDateStatic(r.dateReported),
      reporterName: r.createdByName,
      reporterImageUrl: r.reporterPictureUrl,
      postType: r.type == 'LostItem' ? 'Lost' : 'Found',
      postCategory: r.categoryName,
    );
  }

  static String formatDateStatic(String raw) {
    try {
      final dt = DateTime.parse(raw);
      const months = [
        '', 'January', 'February', 'March', 'April', 'May', 'June',
        'July', 'August', 'September', 'October', 'November', 'December'
      ];
      const days = [
        '', 'Monday', 'Tuesday', 'Wednesday',
        'Thursday', 'Friday', 'Saturday', 'Sunday'
      ];
      return '${days[dt.weekday]}, ${months[dt.month]} ${dt.day}, ${dt.year}';
    } catch (_) {
      return raw;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLost = postType == 'Lost';
    final typeColor = isLost ? Colors.red : Colors.green;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 8,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.r),
              topRight: Radius.circular(16.r),
            ),
            child: postImageUrl != null
                ? CachedNetworkImage(
                    imageUrl: postImageUrl!,
                    height: 180.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: (_, __) => _imagePlaceholder(),
                    errorWidget: (_, __, ___) => _imagePlaceholder(),
                  )
                : _imagePlaceholder(),
          ),

          Padding(
            padding: EdgeInsets.all(12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        postTitle,
                        style: AppStyles.black25W400Style.copyWith(
                          fontSize: 16.sp,
                          fontWeight: const FontWeight(700),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    _buildBadge(postType, typeColor),
                    if (postCategory.isNotEmpty) ...[
                      SizedBox(width: 6.w),
                      _buildBadge(postCategory, AppColors.primaryColor),
                    ],
                  ],
                ),
                SizedBox(height: 6.h),

                Text(
                  postDescription,
                  style: AppStyles.subTitleTextStyle.copyWith(fontSize: 13.sp),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 10.h),

                _buildIconRow(Icons.location_on_outlined, location),
                SizedBox(height: 4.h),

                _buildIconRow(Icons.calendar_today_outlined, date),
                SizedBox(height: 10.h),

                const Divider(height: 1),
                SizedBox(height: 10.h),

                Row(
                  children: [
                    _buildReporterAvatar(),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        reporterName,
                        style: AppStyles.subTitleTextStyle.copyWith(
                          fontWeight: const FontWeight(600),
                          fontSize: 13.sp,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _imagePlaceholder() {
    return Container(
      height: 180.h,
      width: double.infinity,
      color: AppColors.coolGray,
      child: Icon(Icons.image_not_supported_outlined,
          size: 40.sp, color: Colors.grey[400]),
    );
  }

  Widget _buildBadge(String text, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
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

  Widget _buildIconRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 14.sp, color: AppColors.primaryColor),
        SizedBox(width: 4.w),
        Expanded(
          child: Text(
            text,
            style: AppStyles.subTitleTextStyle.copyWith(fontSize: 12.sp),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildReporterAvatar() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.r),
      child: reporterImageUrl != null
          ? CachedNetworkImage(
              imageUrl: reporterImageUrl!,
              width: 32.w,
              height: 32.h,
              fit: BoxFit.cover,
              errorWidget: (_, __, ___) => _defaultAvatar(),
            )
          : _defaultAvatar(),
    );
  }

  Widget _defaultAvatar() {
    return Container(
      width: 32.w,
      height: 32.h,
      color: AppColors.coolGray,
      child: Icon(Icons.person, size: 18.sp, color: Colors.grey[500]),
    );
  }
}
