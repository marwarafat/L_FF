import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/constants/app_styles.dart';
import '../../../../core/widgets/custom_back_button.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../features/home/presentation/cubit/ai_scanning/ai_scanning_cubit.dart';
import '../../../../l10n/app_localizations.dart';

class AiScanningScreen extends StatelessWidget {
  const AiScanningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AiScanningCubit(),
      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.all(16.h),
            child: BlocBuilder<AiScanningCubit, AiScanningState>(
              builder: (context, state) {
                final cubit = context.read<AiScanningCubit>();
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(context),
                    SizedBox(height: 42.h),
                    _buildCameraButton(context, cubit, state),
                    SizedBox(height: 32.h),
                    _buildImagesSection(context, cubit, state),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        const CustomBackButton(),
        SizedBox(width: 16.w),
        Text(
          AppLocalizations.of(context)!.ai_scanning,
          style: AppStyles.subTitleTextStyle.copyWith(
            fontWeight: const FontWeight(800),
          ),
        ),
      ],
    );
  }

  Widget _buildCameraButton(BuildContext context, AiScanningCubit cubit, AiScanningState state) {
    return GestureDetector(
      onTap: state.status == AiScanStatus.loading ? null : cubit.openCamera,
      child: CustomTextFormField(
        width: 371.w,
        height: 47.h,
        borderColor: AppColors.primaryColor,
        hintText: state.status == AiScanStatus.loading
            ? AppLocalizations.of(context)!.opening_camera
            : AppLocalizations.of(context)!.open_camera,
        prefixIcon: state.status == AiScanStatus.loading
            ? SizedBox(
                width: 20.w,
                height: 20.h,
                child: const CircularProgressIndicator(strokeWidth: 2),
              )
            : Image.asset(AppImages.cameraIcon),
        // enabled: false, // taps handled by GestureDetector above
      ),
    );
  }

  Widget _buildImagesSection(BuildContext context, AiScanningCubit cubit, AiScanningState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.arrow_drop_down),
            Text(AppLocalizations.of(context)!.images_count(state.scannedImages.length.toString())),
          ],
        ),
        if (state.scannedImages.isNotEmpty) ...[
          SizedBox(height: 12.h),
          SizedBox(
            height: 100.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: state.scannedImages.length,
              separatorBuilder: (_, __) => SizedBox(width: 10.w),
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.r),
                      child: Image.file(
                        File(state.scannedImages[index]),
                        width: 90.w,
                        height: 100.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 4,
                      right: 4,
                      child: GestureDetector(
                        onTap: () => cubit.removeImage(index),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.black54,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
        if (state.status == AiScanStatus.failure && state.errorMessage != null)
          Padding(
            padding: EdgeInsets.only(top: 8.h),
            child: Text(
              state.errorMessage!,
              style: TextStyle(color: Colors.red, fontSize: 13.sp),
            ),
          ),
      ],
    );
  }
}
