import 'package:flutter/material.dart';
import '../../../domain/entities/report_summary_entity.dart';
import 'package:intl/intl.dart';
import '../../../../../core/styles/app_colors.dart';

class ReportCard extends StatelessWidget {
  final ReportSummaryEntity report;
  final String profileName;

  const ReportCard({
    super.key,
    required this.report,
    required this.profileName,
  });

  @override
  Widget build(BuildContext context) {
    String formattedDate = '';
    if (report.dateReported != null) {
      try {
        DateTime date = DateTime.parse(report.dateReported!);
        formattedDate = DateFormat('EEEE, MMMM d, yyyy').format(date);
      } catch (e) {
        formattedDate = report.dateReported!;
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: AppColors.greyMedium),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(15),
                  ),
                  child:
                      report.imageUrl != null &&
                          report.imageUrl!.startsWith('http')
                      ? Image.network(
                          report.imageUrl!,
                          height: 150,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              "assets/images/profile_img.png",
                              height: 150,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            );
                          },
                        )
                      : Image.asset(
                          "assets/images/profile_img.png",
                          height: 150,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                ),
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: report.type.toLowerCase().contains('lost')
                          ? AppColors.dangerLight
                          : Colors.green,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      report.type
                          .replaceAll('Item', '')
                          .replaceAll('Person', ''),
                      style: const TextStyle(
                        fontFamily: 'AbhayaLibre',
                        color: AppColors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    report.title,
                    style: const TextStyle(
                      fontFamily: 'AbhayaLibre',
                      fontSize: 25,
                      fontWeight: FontWeight.w400,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    report.description,
                    style: const TextStyle(
                      fontFamily: 'AbhayaLibre',
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Column(
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/icons/location_fill.png',
                        width: 16,
                        height: 16,
                        color: AppColors.textTertiary,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          report.locationName,
                          style: const TextStyle(
                            fontFamily: 'AbhayaLibre',
                            color: AppColors.textTertiary,
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  if (formattedDate.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Image.asset(
                          'assets/icons/calendar_date_light.png',
                          width: 16,
                          height: 16,
                          color: AppColors.textTertiary,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            formattedDate,
                            style: const TextStyle(
                              fontFamily: 'AbhayaLibre',
                              color: AppColors.textTertiary,
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  Image.asset(
                    'assets/icons/profile_fill.png',
                    width: 16,
                    height: 16,
                    color: AppColors.greyMedium,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    profileName,
                    style: const TextStyle(
                      fontFamily: 'AbhayaLibre',
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/icons/comment_icon.png',
                        width: 20,
                        height: 20,
                      ),
                      const SizedBox(width: 6),
                      const Text(
                        "Comment",
                        style: TextStyle(
                          fontFamily: 'AbhayaLibre',
                          color: AppColors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Image.asset(
                        'assets/icons/comment_icon.png',
                        width: 20,
                        height: 20,
                      ),
                      const SizedBox(width: 6),
                      const Text(
                        "Connect",
                        style: TextStyle(
                          fontFamily: 'AbhayaLibre',
                          color: AppColors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
