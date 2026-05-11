import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../l10n/app_localizations.dart';
import 'bloc/report_bloc.dart';
import 'bloc/report_event.dart';
import 'bloc/report_state.dart';
import '../widgets/min_widget/custom_text_field.dart';
import '../widgets/min_widget/report_dropdown.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/styles/app_colors.dart';

class ReportAbuse extends StatefulWidget {
  const ReportAbuse({super.key});

  @override
  State<ReportAbuse> createState() => _ReportAbuseState();
}

class _ReportAbuseState extends State<ReportAbuse> {
  String? selectedValue;
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _otherReasonController = TextEditingController();

  @override
  void dispose() {
    _descriptionController.dispose();
    _otherReasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocProvider(
      create: (context) => ReportAbuseBloc(),
      child: BlocConsumer<ReportAbuseBloc, ReportAbuseState>(
        listener: (context, state) {
          if (state is ReportSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(l10n.reportSubmittedSuccess), backgroundColor: Colors.green),
            );
            Navigator.pop(context);
          } else if (state is ReportError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message), backgroundColor: Colors.red),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.white,
            appBar: AppBar(
              backgroundColor: const Color.fromARGB(255, 255, 255, 255),
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.black, size: 18),
                onPressed: () => Navigator.pop(context),
              ),
              title: Text(
                l10n.reportAbuseTitle,
                style: const TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.w800,
                  fontSize: 20,
                  fontFamily: 'AbhayaLibre',
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/icons/flag_twotone.png',
                        width: 80,
                        height: 80,
                        color: AppColors.dangerLighter,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        l10n.reportAbuseTitle,
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 28,
                          color: AppColors.black,
                          fontFamily: 'AbhayaLibre',
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        l10n.reportAbusePageSubtitle,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: AppColors.black,
                          fontFamily: 'AbhayaLibre',
                        ),
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(height: 30),
                      ReportDropdown(
                        value: selectedValue,
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value;
                          });
                        },
                      ),
                      if (selectedValue == "other") ...[
                        const SizedBox(height: 10),
                        CustomTextField(
                          label: "",
                          hint: l10n.enterReasonHint,
                          controller: _otherReasonController,
                        ),
                      ],
                      const SizedBox(height: 10),
                      CustomTextField(
                        label: "",
                        hint: l10n.describeIssueHint,
                        maxLines: 4,
                        controller: _descriptionController,
                      ),
                      const SizedBox(height: 40),
                      CustomButton(
                        text: l10n.submitReport,
                        onPressed: () {
                          final reason = selectedValue == "other"
                              ? _otherReasonController.text
                              : (selectedValue ?? "Unspecified");
                          context.read<ReportAbuseBloc>().add(
                                ReportSubmitted(
                                  reason: reason,
                                  description: _descriptionController.text,
                                ),
                              );
                        },
                        isLoading: state is ReportLoading,
                        backgroundColor: AppColors.dangerLighter,
                        height: 45,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
