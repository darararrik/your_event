import 'package:json_annotation/json_annotation.dart';
import 'package:yourevent/core/data/repositories/models/agency/contact_info/agency_contact_info_dto.dart';
part 'agency_dto.g.dart';

@JsonSerializable()
class AgencyDto {
  final int id;
  final String name;
  final DateTime registrationDate;
  final bool verified;
  final AgencyContactInfoDto contactInfo;

  AgencyDto(
      {required this.id,
      required this.name,
      required this.registrationDate,
      required this.verified,
      required this.contactInfo});

  factory AgencyDto.fromJson(Map<String, dynamic> json) =>
      _$AgencyDtoFromJson(json);
  Map<String, dynamic> toJson() => _$AgencyDtoToJson(this);
}
