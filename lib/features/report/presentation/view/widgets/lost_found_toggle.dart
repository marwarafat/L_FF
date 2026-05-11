import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/report_bloc.dart';
import '../../bloc/report_event.dart';
import '../../bloc/report_state.dart';
import '../../../../../core/styles/app_colors.dart';

class LostFoundToggle extends StatelessWidget {
  const LostFoundToggle({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportBloc, ReportState>(
      builder: (context, state) {
        return Row(
          children: [
            // زرار I lost item
            Expanded(
              child: GestureDetector(
                onTap: () => context.read<ReportBloc>().add(SetLostFound(true)),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: state.isLost == true
                        ? AppColors.danger
                        : AppColors.border,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text(
                      "I lost item",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            // زرار I found item
            Expanded(
              child: GestureDetector(
                onTap: () =>
                    context.read<ReportBloc>().add(SetLostFound(false)),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: state.isLost == false
                        ? AppColors.success
                        : AppColors.border,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text(
                      "I found item",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
