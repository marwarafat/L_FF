import 'package:flutter/foundation.dart';
import '../../../../core/networking/api_keys.dart';
import '../../../../features/auth/data/models/user_model.dart';

class AuthResponseModel {
  final UserModel user;
  final String accessToken;
  final String refreshToken;
  final String expiresAt;

  const AuthResponseModel({
    required this.user,
    required this.accessToken,
    required this.refreshToken,
    required this.expiresAt,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    if (kDebugMode) {
      debugPrint(' AuthResponseModel.fromJson keys: ${json.keys.toList()}');
    }

  
    final userJson = json[ApiKeys.user] as Map<String, dynamic>?;

    if (userJson == null) {
      if (kDebugMode) {
        debugPrint('⚠️ No "user" key found. Full data: $json');
        debugPrint('Trying to parse user from root object...');
      }
      return AuthResponseModel(
        user: UserModel.fromJson(json),
        accessToken: (json[ApiKeys.accessToken] ?? json['token'] ?? json['access_token']) as String? ?? '',
        refreshToken: (json[ApiKeys.refreshToken] ?? json['refresh_token']) as String? ?? '',
        expiresAt: json[ApiKeys.expiresAt] as String? ?? '',
      );
    }

    return AuthResponseModel(
      user: UserModel.fromJson(userJson),
      accessToken: (json[ApiKeys.accessToken] ?? json['token'] ?? json['access_token']) as String? ?? '',
      refreshToken: (json[ApiKeys.refreshToken] ?? json['refresh_token']) as String? ?? '',
      expiresAt: json[ApiKeys.expiresAt] as String? ?? '',
    );
  }
}
