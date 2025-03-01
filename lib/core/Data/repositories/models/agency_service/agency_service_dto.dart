import 'package:json_annotation/json_annotation.dart';
part 'agency_service_dto.g.dart';

@JsonSerializable()
class AgencyServiceDto {
  //TODO: добавить в сущность город и рейтинг

  final String agencyName;
  final String serviceName;
  final String serviceTypeName;
  final double price;

  AgencyServiceDto(
      {required this.agencyName,
      required this.serviceName,
      required this.serviceTypeName,
      required this.price});

  factory AgencyServiceDto.fromJson(Map<String, dynamic> json) =>
      _$AgencyServiceDtoFromJson(json);
  Map<String, dynamic> toJson() => _$AgencyServiceDtoToJson(this);
}
