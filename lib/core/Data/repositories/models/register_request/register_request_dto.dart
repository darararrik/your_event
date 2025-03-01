import 'package:json_annotation/json_annotation.dart';

part 'register_request_dto.g.dart';

@JsonSerializable()
class RegisterRequestDto {
  final String name;
  final String surname;
  final String email;
  final String password;

  RegisterRequestDto({
    required this.name,
    required this.surname,
    required this.email,
    required this.password,
  });

  factory RegisterRequestDto.fromJson(Map<String, dynamic> json) => _$RegisterRequestDtoFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterRequestDtoToJson(this);
}