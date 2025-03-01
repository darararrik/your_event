import 'package:json_annotation/json_annotation.dart';
part 'tokes_response_dto.g.dart';

@JsonSerializable()
class TokesResponseDto {
  final String accessToken;
  final String refreshToken;

  TokesResponseDto({required this.accessToken, required this.refreshToken});
  factory TokesResponseDto.fromJson(Map<String, dynamic> json) =>
      _$TokesResponseDtoFromJson(json);
  Map<String, dynamic> toJson() => _$TokesResponseDtoToJson(this);
}
