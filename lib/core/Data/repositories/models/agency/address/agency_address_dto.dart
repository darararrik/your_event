import 'package:json_annotation/json_annotation.dart';
part 'agency_address_dto.g.dart';

@JsonSerializable()
class AddressDto {
  final String city;
  final String street;
  final String building;

  AddressDto({
    required this.city,
    required this.street,
    required this.building,
  });

  factory AddressDto.fromJson(Map<String, dynamic> json) =>
      _$AddressDtoFromJson(json);
  Map<String, dynamic> toJson() => _$AddressDtoToJson(this);
}
