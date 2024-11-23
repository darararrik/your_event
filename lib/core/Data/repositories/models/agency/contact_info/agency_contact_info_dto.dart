import 'package:json_annotation/json_annotation.dart';
import 'package:yourevent/core/data/repositories/models/agency/address/agency_address_dto.dart';
part 'agency_contact_info_dto.g.dart';

@JsonSerializable()
class AgencyContactInfoDto {
  final String email;
  final String phone;
  final AddressDto address;

  AgencyContactInfoDto({
    required this.email,
    required this.phone,
    required this.address,
  });

  factory AgencyContactInfoDto.fromJson(Map<String, dynamic> json) =>
      _$AgencyContactInfoDtoFromJson(json);
  Map<String, dynamic> toJson() => _$AgencyContactInfoDtoToJson(this);
}
