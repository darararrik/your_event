import 'package:json_annotation/json_annotation.dart';
import 'package:yourevent/core/data/repositories/models/user/user_dto.dart';

part 'auth_response_dto.g.dart';

@JsonSerializable()
class AuthResponseDto {
  final String accessToken;
  final String refreshToken;
  final UserDto userDto;

  AuthResponseDto({
    required this.userDto,
    required this.accessToken,
    required this.refreshToken,
  });

  factory AuthResponseDto.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseDtoFromJson(json);
  Map<String, dynamic> toJson() => _$AuthResponseDtoToJson(this);
}
