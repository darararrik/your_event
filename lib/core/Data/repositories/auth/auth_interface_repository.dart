import 'package:yourevent/core/data/repositories/models/models.dart';

abstract interface class IAuthRepository {
  Future<AuthResponseDto> signUp(RegisterRequestDto registerRequest);
  Future<AuthResponseDto> signIn(LoginRequestDto loginRequest);
  Future<void> logout();
}
