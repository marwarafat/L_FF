import 'package:google_sign_in/google_sign_in.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/storage/token_storage.dart';
import '../../../../core/utils/token_storage.dart';
import '../../../../features/auth/data/repo/auth_remote_data_source.dart';
import '../../../../features/auth/data/models/auth_response_model.dart';

class AuthRepo {
  final AuthRemoteDataSource remoteDataSource;
  final TokenStorage tokenStorage;

  AuthRepo({required this.remoteDataSource, required this.tokenStorage});


  Future<void> signUp({
    required String firstName,
    required String lastName,
    required String dateOfBirth,
    required String gender,
    required String email,
    required String phone,
    required String password,
  }) async {
    await remoteDataSource.signUp(
      firstName: firstName,
      lastName: lastName,
      dateOfBirth: dateOfBirth,
      gender: gender,
      email: email,
      phone: phone,
      password: password,
    );
  }


  Future<AuthResponseModel> login({
    required String email,
    required String password,
  }) async {
    final result = await remoteDataSource.login(
      email: email,
      password: password,
    );
    await tokenStorage.saveTokens(result.accessToken, result.refreshToken);
    await CacheHelper.saveData(key: "token", value: result.accessToken);
    return result;
  }

  Future<AuthResponseModel> googleSignIn() async {
    const webClientId =
        '628767787869-53rb7jfk8cetck75243frfsrug9d87rh.apps.googleusercontent.com';

    final googleSignIn = GoogleSignIn(
      serverClientId: webClientId,
      scopes: ['email', 'profile'],
    );

    await googleSignIn.signOut();

    final googleUser = await googleSignIn.signIn();

    if (googleUser == null) {
      throw ServerException('Google sign-in was cancelled.');
    }

    final googleAuth = await googleUser.authentication;
    final idToken = googleAuth.idToken;

    if (idToken == null) {
      throw ServerException(
        'Failed to get Google ID token. '
        'Make sure SHA-1 is added in Firebase and google-services.json is updated.',
      );
    }

    final result = await remoteDataSource.googleSignIn(idToken: idToken);
    await tokenStorage.saveTokens(result.accessToken, result.refreshToken);
    await CacheHelper.saveData(key: "token", value: result.accessToken);
    return result;
  }


  Future<void> verifyAccount({
    required String email,
    required String code,
  }) async {
    await remoteDataSource.verifyAccount(email: email, code: code);
  }


  Future<void> resendVerification({required String email}) async {
    await remoteDataSource.resendVerification(email: email);
  }


  Future<void> forgotPassword({required String email}) async {
    await remoteDataSource.forgotPassword(email: email);
  }


  Future<void> resetPassword({
    required String email,
    required String resetToken,
    required String newPassword,
  }) async {
    await remoteDataSource.resetPassword(
      email: email,
      resetToken: resetToken,
      newPassword: newPassword,
    );
  }


  Future<void> logout() async {
    final refreshToken = await tokenStorage.getRefreshToken();
    if (refreshToken != null) {
      await remoteDataSource.logout(refreshToken: refreshToken);
    }
    await tokenStorage.clear();
    await CacheHelper.removeData(key: "token");
  }


  Future<String?> getStoredToken() async {
    return tokenStorage.getAccessToken();
  }
}
