import 'package:json_annotation/json_annotation.dart';
part 'event_type_model.g.dart';

@JsonSerializable()
class EventTypeModel {
  final int id;
  final String name;
  final String imageUrl;
  const EventTypeModel(
      {required this.id, required this.name, required this.imageUrl});

  factory EventTypeModel.fromJson(Map<String, dynamic> json) =>
      _$EventTypeModelFromJson(json);
  Map<String, dynamic> toJson() => _$EventTypeModelToJson(this);
}
