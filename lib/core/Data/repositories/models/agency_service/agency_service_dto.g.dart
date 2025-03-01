// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agency_service_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AgencyServiceDto _$AgencyServiceDtoFromJson(Map<String, dynamic> json) =>
    AgencyServiceDto(
      agencyName: json['agencyName'] as String,
      serviceName: json['serviceName'] as String,
      serviceTypeName: json['serviceTypeName'] as String,
      price: (json['price'] as num).toDouble(),
    );

Map<String, dynamic> _$AgencyServiceDtoToJson(AgencyServiceDto instance) =>
    <String, dynamic>{
      'agencyName': instance.agencyName,
      'serviceName': instance.serviceName,
      'serviceTypeName': instance.serviceTypeName,
      'price': instance.price,
    };
