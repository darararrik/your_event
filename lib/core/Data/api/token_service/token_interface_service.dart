abstract class ITokenService {
  String? getAccessToken();
  String? getRefreshToken();
  Future<void> saveTokens({required String accessToken, required String refreshToken});
  Future<void> deleteTokens();
}


