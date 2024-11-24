import 'package:yourevent/core/core.dart';
import 'package:yourevent/core/data/repositories/user/user_interface_repository.dart';

class UserRepository implements IUserRepository {
  final ApiService _apiService;

  UserRepository(this._apiService);
  @override
  Future<AuthResponseDto> updatePassword(
      {required String oldPassword, required String newPassword}) async {
    return await _apiService.updatePassword(
        oldPassword: oldPassword, newPassword: newPassword);
  }

  @override
  Future<UserDto> updateCity({required String city}) {
    // TODO: implement updateCity
    throw UnimplementedError();
  }

  @override
  Future<AuthResponseDto> updateEmail({required String newEmail}) {
    return _apiService.updateEmail(newEmail: newEmail);
  }

  @override
  Future<UserDto> updateName({required String name, required String surname}) {
    return _apiService.updateName(name: name, surname: surname);
  }

  @override
  Future<UserDto> getCurrentUser() {
    return _apiService.getCurrentUser();
  }
}
