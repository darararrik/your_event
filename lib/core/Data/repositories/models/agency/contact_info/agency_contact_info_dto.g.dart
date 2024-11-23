// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agency_contact_info_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AgencyContactInfoDto _$AgencyContactInfoDtoFromJson(
        Map<String, dynamic> json) =>
    AgencyContactInfoDto(
      email: json['email'] as String,
      phone: json['phone'] as String,
      address: AddressDto.fromJson(json['address'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AgencyContactInfoDtoToJson(
        AgencyContactInfoDto instance) =>
    <String, dynamic>{
      'email': instance.email,
      'phone': instance.phone,
      'address': instance.address,
    };
