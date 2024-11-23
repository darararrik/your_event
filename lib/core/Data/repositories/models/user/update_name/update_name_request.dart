import 'package:json_annotation/json_annotation.dart';
part 'update_name_request.g.dart';
@JsonSerializable()
class UpdateNameRequest {
  final String name;
  final String surname;

  UpdateNameRequest({
    required this.name,
    required this.surname,
  });

  factory UpdateNameRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateNameRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateNameRequestToJson(this);
}