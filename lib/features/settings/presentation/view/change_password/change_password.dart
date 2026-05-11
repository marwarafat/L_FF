import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/datasources/settings_remote_data_source.dart';
import '../../../data/repositories/settings_repository_impl.dart';
import '../../../domain/usecases/change_password_usecase.dart';
import '../../../../../l10n/app_localizations.dart';
import 'bloc/change_password_bloc.dart';
import 'bloc/change_password_event.dart';
import 'bloc/change_password_state.dart';
import '../widgets/min_widget/password_field.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/styles/app_colors.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocProvider(
      create: (_) {
        final dataSource = SettingsRemoteDataSourceImpl();
        final repository = SettingsRepositoryImpl(dataSource);
        return ChangePasswordBloc(
          changePasswordUseCase: ChangePasswordUseCase(repository),
        );
      },
      child: BlocListener<ChangePasswordBloc, ChangePasswordState>(
        listener: (context, state) {
          if (state.isSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(l10n.passwordUpdatedSuccess),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.pop(context);
          }
          if (state.serverError != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.serverError!),
                backgroundColor: Colors.red,
              ),
            );
          }
        },

        child: BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
          builder: (context, state) {
            return Scaffold(
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
                  l10n.updatePassword,
                  style: const TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                  ),
                ),
              ),

              body: Padding(
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
                      Row(
                        children: [
                          Image.asset(
                            'assets/icons/lock_password.png',
                            color: AppColors.greyMedium,
                            width: 45,
                            height: 45,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            l10n.updatePassword,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: AppColors.black,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      PasswordField(
                        hint: l10n.currentPassword,
                        error: state.currentError,
                        onChanged: (v) {
                          context.read<ChangePasswordBloc>().add(
                            CurrentPasswordChanged(v),
                          );
                        },
                      ),
                      const SizedBox(height: 6),

                      PasswordField(
                        hint: l10n.newPassword,
                        error: state.newError,
                        onChanged: (v) {
                          context.read<ChangePasswordBloc>().add(
                            NewPasswordChanged(v),
                          );
                        },
                      ),
                      const SizedBox(height: 6),

                      PasswordField(
                        hint: l10n.confirmNewPassword,
                        error: state.confirmError,
                        onChanged: (v) {
                          context.read<ChangePasswordBloc>().add(
                            ConfirmPasswordChanged(v),
                          );
                        },
                      ),
                      const Spacer(),

                      CustomButton(
                        text: l10n.updatePassword,
                        onPressed: () {
                          context.read<ChangePasswordBloc>().add(
                            SubmitChangePassword(),
                          );
                        },
                        isLoading: state.isLoading,
                      ),
                    ],
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
