import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../features/auth/data/repo/auth_repo.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final AuthRepo authRepo;

  SignUpCubit({required this.authRepo}) : super(SignUpInitial());

  final formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final dateController = TextEditingController();

  bool isPasswordHidden = true;
  String? selectedGender;

  void togglePasswordVisibility() {
    isPasswordHidden = !isPasswordHidden;
    emit(SignUpPasswordVisibilityChanged(isPasswordHidden: isPasswordHidden));
  }

  void onGenderChanged(String? value) {
    if (value == null) return;
    selectedGender = value;
    emit(SignUpGenderChanged(gender: value));
  }

  Future<void> pickDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(
            primary: AppColors.primaryColor,
            onPrimary: AppColors.whiteColor,
            onSurface: AppColors.mediumDarkGray,
          ),
        ),
        child: child!,
      ),
    );

    if (picked != null) {
      dateController.text = DateFormat('dd/MM/yyyy').format(picked);
      emit(SignUpDateChanged(date: dateController.text));
    }
  }

  Future<void> signUp() async {
    if (!formKey.currentState!.validate()) return;

    emit(SignUpLoading());
    try {
      final parsedDate = DateFormat('dd/MM/yyyy').parse(dateController.text);
      final apiDate = DateFormat('yyyy-MM-dd').format(parsedDate);

      // selectedGender already "Male"/"Female" from dropdown
      await authRepo.signUp(
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        dateOfBirth: apiDate,
        gender: selectedGender!,
        email: emailController.text.trim(),
        phone: phoneController.text.trim(),
        password: passwordController.text,
      );
      emit(SignUpSuccess());
    } on ServerException catch (e) {
      emit(SignUpFailure(errMessage: e.message));
    } catch (e) {
      emit(SignUpFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<void> close() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    dateController.dispose();
    return super.close();
  }
}
