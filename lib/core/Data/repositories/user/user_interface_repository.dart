import 'package:yourevent/core/core.dart';

abstract interface class IUserRepository {
  Future<UserDto> getCurrentUser();
  Future<AuthResponseDto> updatePassword(
      {required String oldPassword, required String newPassword});
  Future<AuthResponseDto> updateEmail({required String newEmail});
  Future<UserDto> updateName({required String name, required String surname});
  Future<UserDto> updateCity({required String city});
}
