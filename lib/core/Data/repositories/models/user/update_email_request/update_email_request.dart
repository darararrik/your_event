
import 'package:json_annotation/json_annotation.dart';
part 'update_email_request.g.dart';
@JsonSerializable()
class UpdateEmailRequest {
  final String newEmail;

  UpdateEmailRequest({required this.newEmail});

  factory UpdateEmailRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateEmailRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateEmailRequestToJson(this);
}