// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_type_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventTypeDto _$EventTypeDtoFromJson(Map<String, dynamic> json) => EventTypeDto(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String,
    );

Map<String, dynamic> _$EventTypeDtoToJson(EventTypeDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
    };
