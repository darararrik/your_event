import 'package:json_annotation/json_annotation.dart';
import 'package:yourevent/core/data/repositories/models/models.dart';

part 'auth_response.g.dart';

@JsonSerializable()
class AuthResponse {
  final String accessToken;
  final String refreshToken;
  final UserDto userDto;

  AuthResponse({
    required this.userDto,
    required this.accessToken,
    required this.refreshToken,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);
}
