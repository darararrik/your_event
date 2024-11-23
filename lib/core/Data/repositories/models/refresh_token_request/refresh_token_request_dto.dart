import 'package:json_annotation/json_annotation.dart';

part 'refresh_token_request_dto.g.dart';

@JsonSerializable()
class RefreshTokenRequestDto {
  
  final String refreshToken;

  RefreshTokenRequestDto({
    required this.refreshToken,
  });

  factory RefreshTokenRequestDto.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokenRequestDtoFromJson(json);
  Map<String, dynamic> toJson() => _$RefreshTokenRequestDtoToJson(this);
}
