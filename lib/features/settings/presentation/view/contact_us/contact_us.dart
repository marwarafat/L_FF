import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../l10n/app_localizations.dart';
import 'bloc/contact_us_bloc.dart';
import 'bloc/contact_us_event.dart';
import 'bloc/contact_us_state.dart';
import '../widgets/min_widget/custom_text_field.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/styles/app_colors.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocProvider(
      create: (_) => ContactBloc(),
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.black,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            l10n.contactUsTitle,
            style: const TextStyle(
              color: AppColors.black,
              fontWeight: FontWeight.w800,
              fontSize: 20,
            ),
          ),
        ),
        body: Builder(
          builder: (context) {
            return BlocListener<ContactBloc, ContactState>(
              listener: (context, state) {
                if (state.error != null || state.success) {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                }

                if (state.error != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.error!),
                      backgroundColor: Colors.red,
                    ),
                  );
                }

                if (state.success) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(l10n.messageSentSuccess),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              },
              child: SingleChildScrollView(
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
                        Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: Image.asset(
                            'assets/icons/email_fill.png',
                            width: 100,
                            height: 100,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          l10n.contactUsTitle,
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 30,
                            color: AppColors.black,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          l10n.contactUsPageSubtitle,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: AppColors.black,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        const SizedBox(height: 40),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextField(
                              label: l10n.subject,
                              hint: l10n.subjectHint,
                              onChanged: (value) {
                                context.read<ContactBloc>().add(UpdateSubject(value));
                              },
                            ),
                            const SizedBox(height: 10),
                            CustomTextField(
                              label: l10n.message,
                              hint: l10n.howCanWeHelp,
                              maxLines: 4,
                              onChanged: (value) {
                                context.read<ContactBloc>().add(UpdateMessage(value));
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 60),
                        BlocBuilder<ContactBloc, ContactState>(
                          builder: (context, state) {
                            return CustomButton(
                              text: l10n.sendMessage,
                              onPressed: () {
                                context.read<ContactBloc>().add(SendMessage());
                              },
                              isLoading: state.loading,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
