import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/app_styles.dart';
import '../../../../../l10n/app_localizations.dart';

class SignOrWidget extends StatelessWidget {
  const SignOrWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 142.w, child: Divider()),
        Padding(
          padding: EdgeInsetsGeometry.only(left: 12.w, right: 13.w),
          child: Text(
            AppLocalizations.of(context)!.or,
            style: AppStyles.black25W400Style.copyWith(fontSize: 20.sp),
          ),
        ),

        SizedBox(width: 142.w, child: Divider()),
      ],
    );
  }
}
