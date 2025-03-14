
import 'package:json_annotation/json_annotation.dart';
part 'update_password_request.g.dart';
@JsonSerializable()
class UpdatePasswordRequest {
  final String oldPassword;
  final String newPassword;

  UpdatePasswordRequest({
    required this.oldPassword,
    required this.newPassword,
  });

  factory UpdatePasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdatePasswordRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UpdatePasswordRequestToJson(this);
}