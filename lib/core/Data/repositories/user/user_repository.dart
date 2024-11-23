import 'package:yourevent/core/data/api/api_service.dart';
import 'package:yourevent/core/data/repositories/models/user/user_dto.dart';
import 'package:yourevent/core/data/repositories/user/user_interface_repository.dart';

class UserRepository implements IUserRepository {
  final ApiService _apiService;

  UserRepository(this._apiService);
  @override
  Future<UserDto> updatePassword(
      {required String oldPassword, required String newPassword}) {
    return _apiService.updatePassword(
        oldPassword: oldPassword, newPassword: newPassword);
  }

  @override
  Future<UserDto> updateCity({required String city}) {
    // TODO: implement updateCity
    throw UnimplementedError();
  }

  @override
  Future<UserDto> updateEmail({required String password}) {
    // TODO: implement updateEmail
    throw UnimplementedError();
  }


  @override
  Future<UserDto> updateName({required String name,required String surname}) {
    return _apiService.updateName(name: name,surname: surname );
  }

  @override
  Future<UserDto> getCurrentUser() {
    return _apiService.getCurrentUser();
  }
}
