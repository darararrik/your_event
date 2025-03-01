import 'package:json_annotation/json_annotation.dart';
part 'event_type_dto.g.dart';

@JsonSerializable()
class EventTypeDto {
  final int id;
  final String name;
  final String imageUrl;
  const EventTypeDto(
      {required this.id, required this.name, required this.imageUrl});

  factory EventTypeDto.fromJson(Map<String, dynamic> json) =>
      _$EventTypeDtoFromJson(json);
  Map<String, dynamic> toJson() => _$EventTypeDtoToJson(this);
}
