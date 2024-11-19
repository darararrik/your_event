// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_type_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventTypeModel _$EventTypeModelFromJson(Map<String, dynamic> json) =>
    EventTypeModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String,
    );

Map<String, dynamic> _$EventTypeModelToJson(EventTypeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
    };
