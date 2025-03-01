// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agency_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AgencyDto _$AgencyDtoFromJson(Map<String, dynamic> json) => AgencyDto(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      registrationDate: DateTime.parse(json['registrationDate'] as String),
      verified: json['verified'] as bool,
      contactInfo: AgencyContactInfoDto.fromJson(
          json['contactInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AgencyDtoToJson(AgencyDto instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'registrationDate': instance.registrationDate.toIso8601String(),
      'verified': instance.verified,
      'contactInfo': instance.contactInfo,
    };
