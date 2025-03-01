// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agency_address_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressDto _$AddressDtoFromJson(Map<String, dynamic> json) => AddressDto(
      city: json['city'] as String,
      street: json['street'] as String,
      building: json['building'] as String,
    );

Map<String, dynamic> _$AddressDtoToJson(AddressDto instance) =>
    <String, dynamic>{
      'city': instance.city,
      'street': instance.street,
      'building': instance.building,
    };
