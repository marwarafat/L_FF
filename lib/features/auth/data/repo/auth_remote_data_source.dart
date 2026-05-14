import 'package:flutter/foundation.dart';
import '../../../../core/networking/api_constants.dart';
import '../../../../core/networking/api_consumer.dart';
import '../../../../core/networking/api_keys.dart';
import '../../../../features/auth/data/models/auth_response_model.dart';

class AuthRemoteDataSource {
  final ApiConsumer api;

  AuthRemoteDataSource(this.api);

  Map<String, dynamic> _extractData(dynamic raw) {
    if (raw == null) throw Exception('Response is null');
    final body = raw as Map<String, dynamic>;
    if (kDebugMode) debugPrint(' API Response: $body');
    final data = body[ApiKeys.data];
    if (data == null) throw Exception('Response "data" is null.\nFull: $body');
    return data as Map<String, dynamic>;
  }



  Future<void> signUp({
    required String firstName,
    required String lastName,
    required String dateOfBirth,
    required String gender,
    required String email,
    required String phone,
    required String password,
  }) async {
    final raw = await api.post(
      ApiConstants.signup,
      data: {
        'firstName': firstName,
        'lastName': lastName,
        'dateOfBirth': dateOfBirth,
        'gender': gender,
        'email': email,
        'phone': phone,
        'password': password,
      },
    );

    if (raw != null) {
      final body = raw as Map<String, dynamic>;
      final success = body[ApiKeys.success] as bool? ?? false;
      if (!success) {
        final message = body[ApiKeys.message] as String? ?? 'Registration failed';
        throw Exception(message);
      }
    }
  }


  Future<AuthResponseModel> login({
    required String email,
    required String password,
  }) async {
    final raw = await api.post(
      ApiConstants.login,
      data: {'email': email, 'password': password},
    );
    return AuthResponseModel.fromJson(_extractData(raw));
  }


  Future<AuthResponseModel> googleSignIn({required String idToken}) async {
    final raw = await api.post(
      ApiConstants.google,
      data: {'idToken': idToken},
    );
    return AuthResponseModel.fromJson(_extractData(raw));
  }


  Future<void> verifyAccount({
    required String email,
    required String code,
  }) async {
    await api.get(
      ApiConstants.verifyAccount,
      queryParameters: {'email': email, 'code': code},
    );
  }


  Future<void> resendVerification({required String email}) async {
    await api.post(
      ApiConstants.resendVerification,
      data: {'email': email},
    );
  }


  Future<void> forgotPassword({required String email}) async {
    await api.post(
      ApiConstants.forgotPassword,
      data: {'email': email},
    );
  }


  Future<void> resetPassword({
    required String email,
    required String resetToken,
    required String newPassword,
  }) async {
    await api.post(
      ApiConstants.resetPassword,
      data: {
        'email': email,
        'resetToken': resetToken,
        'newPassword': newPassword,
      },
    );
  }


  Future<void> logout({required String refreshToken}) async {
    await api.post(
      ApiConstants.logout,
      headers: {'requiresAuth': true},
    );
  }
}
