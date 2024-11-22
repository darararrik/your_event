

import 'package:yourevent/core/data/repositories/models/models.dart';

abstract interface class IAuthRepository {
  Future<AuthResponseDto> singUp(RegisterRequestDto registerRequest);
  Future<AuthResponseDto> signIn(LoginRequestDto loginRequest);
  Future<String?> getAccessToken();
  Future<String?> getRefreshToken();
  Future<void> saveTokens(String accessToken, String refreshToken);
}
