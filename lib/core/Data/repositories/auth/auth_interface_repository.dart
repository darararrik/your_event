import '../../api/apiModels/models.dart';

abstract interface class IAuthRepository {
  Future<AuthResponse> singUp(RegisterRequest registerRequest);
  Future<AuthResponse> signIn(LoginRequest loginRequest);
  Future<String?> getAccessToken();
  Future<String?> getRefreshToken();
  Future<void> saveTokens(String accessToken, String refreshToken);
}
