import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/constants/app_styles.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/widgets/category_container.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../features/home/presentation/cubit/home/home_cubit.dart';
import '../../../../features/home/presentation/screens/widgets/post_widget.dart';
import '../../../../l10n/app_localizations.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static List<String> _filters(BuildContext context) => [
        AppLocalizations.of(context)!.all,
        AppLocalizations.of(context)!.lost,
        AppLocalizations.of(context)!.found
      ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(homeRepo: sl(), categoryRepo: sl())..init(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return RefreshIndicator(
            onRefresh: () {
              return context.read<HomeCubit>().refresh();
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(child: SizedBox(height: 15.h)),
                  SliverToBoxAdapter(child: _buildHeader(context)),
                  SliverToBoxAdapter(child: SizedBox(height: 20.h)),
                  SliverToBoxAdapter(child: _buildSearchBar(context)),
                  SliverToBoxAdapter(child: SizedBox(height: 12.h)),
                  SliverToBoxAdapter(
                    child: _buildFilterRow(context, state),
                  ),
                  SliverToBoxAdapter(child: SizedBox(height: 12.h)),
                  if (state.status == HomeStatus.success)
                    SliverToBoxAdapter(
                      child: _buildCategoryRow(context, state),
                    ),
                  SliverToBoxAdapter(child: SizedBox(height: 6.h)),
                  const SliverToBoxAdapter(child: Divider()),
                  SliverToBoxAdapter(child: SizedBox(height: 6.h)),
                  ..._buildBody(context, state),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text(
              "WASIT KHIER",

              style: AppStyles.primary30W800Style.copyWith(
                fontWeight: const FontWeight(400),
                fontSize: 32.sp,
              ),
            ),

            Text(
              AppLocalizations.of(context)!.connecting_lost_souls,

              style: AppStyles.black25W400Style.copyWith(
                fontSize: 18.sp,
                fontWeight: const FontWeight(500),
              ),
            ),
          ],
        ),

        const Spacer(),

        InkWell(
          onTap: () => Navigator.pushNamed(context, AppRoutes.notifications),
          child: Image.asset(AppImages.notificationIcon, height: 30.h, width: 30.w),
        ),

        SizedBox(width: 16.w),

        InkWell(
          onTap: () => Navigator.pushNamed(context, AppRoutes.profile),
          child: Image.asset(AppImages.profileIcon, height: 25.h, width: 25.w),
        ),
      ],
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return CustomTextFormField(
      width: double.infinity,
      height: 60.h,

      borderColor: AppColors.primaryColor,

      hintText: AppLocalizations.of(context)!.search_hint,

      prefixIcon: Image.asset(AppImages.searchIcon),

      prefixPadding: EdgeInsets.only(left: 15.w, top: 8.h, bottom: 8.h),

      onChanged: (val) {
        context.read<HomeCubit>().updateSearch(val);
      },

      suffixIcon: InkWell(
        onTap: () {
          Navigator.pushNamed(context, AppRoutes.aiScanScreen);
        },

        child: Image.asset(AppImages.cameraIcon),
      ),
    );
  }

  Widget _buildFilterRow(BuildContext context, HomeState state) {
    return Row(
      children: _filters(context).map((filter) {
        final isSelected = state.selectedFilter == filter;

        return Padding(
          padding: EdgeInsets.only(right: 9.w),

          child: GestureDetector(
            onTap: () {
              context.read<HomeCubit>().selectFilter(filter);
            },

            child: CategoryContainer(
              containerText: filter,

              width: filter == AppLocalizations.of(context)!.found ? 79.w : 66.w,

              height: 34.h,

              backgroundColor: isSelected
                  ? AppColors.primaryColor
                  : AppColors.coolGray,

              containerTextColor: isSelected ? Colors.white : Colors.black,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCategoryRow(BuildContext context, HomeState state) {
    final cats = state.categoryNames;

    return SizedBox(
      height: 34.h,

      child: ListView.separated(
        scrollDirection: Axis.horizontal,

        itemCount: cats.length,

        separatorBuilder: (_, __) {
          return SizedBox(width: 9.w);
        },

        itemBuilder: (_, i) {
          final name = cats[i];

          final isSelected = state.selectedCategory == name;

          final width = (name.length * 8 + 24).clamp(50.0, 220.0).w;

          return GestureDetector(
            onTap: () {
              context.read<HomeCubit>().selectCategory(name);
            },

            child: CategoryContainer(
              containerText: name,
              width: width,
              height: 34.h,

              backgroundColor: isSelected
                  ? AppColors.primaryColor
                  : AppColors.coolGray,

              containerTextColor: isSelected ? Colors.white : Colors.black,
            ),
          );
        },
      ),
    );
  }

  List<Widget> _buildBody(BuildContext context, HomeState state) {
    switch (state.status) {
      case HomeStatus.loading:
      case HomeStatus.initial:
        return [
          const SliverFillRemaining(
            child: Center(child: CircularProgressIndicator()),
          ),
        ];

      case HomeStatus.failure:
        return [
          SliverFillRemaining(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,

                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 48),

                  SizedBox(height: 12.h),

                  Text(state.errorMessage ?? AppLocalizations.of(context)!.failed),

                  SizedBox(height: 12.h),

                  ElevatedButton(
                    onPressed: () {
                      context.read<HomeCubit>().refresh();
                    },

                    child: Text(AppLocalizations.of(context)!.retry),
                  ),
                ],
              ),
            ),
          ),
        ];

      case HomeStatus.success:
        final posts = state.filteredReports;

        if (posts.isEmpty) {
          return [
            SliverFillRemaining(
              child: Center(
                child: Text(
                  AppLocalizations.of(context)!.no_posts_found,

                  style: AppStyles.subTitleTextStyle,
                ),
              ),
            ),
          ];
        }

        return [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, i) => Padding(
                padding: EdgeInsets.only(bottom: 12.h),

                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.postDetails,
                      arguments: posts[i],
                    );
                  },

                  child: PostWidget.fromReport(posts[i]),
                ),
              ),

              childCount: posts.length,
            ),
          ),

          SliverToBoxAdapter(child: SizedBox(height: 20.h)),
        ];
    }
  }
}
