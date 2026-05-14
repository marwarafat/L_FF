import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  final storage = const FlutterSecureStorage();

  Future<void> saveTokens(String access, String refresh) async {
    await storage.write(key: "accessToken", value: access);
    await storage.write(key: "refreshToken", value: refresh);
  }

  Future<String?> getAccessToken() async {
    return await storage.read(key: "accessToken");
  }

  Future<String?> getRefreshToken() async {
    return await storage.read(key: "refreshToken");
  }

  Future<void> clear() async {
    await storage.deleteAll();
  }
}
