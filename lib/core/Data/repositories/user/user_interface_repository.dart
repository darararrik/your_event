import 'package:yourevent/core/data/repositories/models/user/user_dto.dart';

abstract interface class IUserRepository {
  Future<UserDto> getCurrentUser();
  Future<UserDto> updatePassword(
      {required String oldPassword, required String newPassword});
  Future<UserDto> updateEmail({required String password});
  Future<UserDto> updateName({required String name, required String surname});
  Future<UserDto> updateCity({required String city});
}
