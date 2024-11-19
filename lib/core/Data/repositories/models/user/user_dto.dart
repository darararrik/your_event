import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:json_annotation/json_annotation.dart';
part 'user_dto.g.dart';

@JsonSerializable()
class UserDto {
  final int id;
  final String name;
  final String surname;
  final String email;
  final String? city = null;

  UserDto({
    required this.id,
    required this.email,
    required this.name,
    required this.surname,
  });

  // Фабричный метод для создания экземпляра из JSON
  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);

  // Метод для преобразования экземпляра в JSON
  Map<String, dynamic> toJson() => _$UserDtoToJson(this);
}
