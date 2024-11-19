// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventModel _$EventModelFromJson(Map<String, dynamic> json) => EventModel(
      categoryName: json['categoryName'] as String?,
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String,
      status: json['status'] as String?,
      price: (json['price'] as num).toInt(),
      categoryId: (json['categoryId'] as num).toInt(),
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      address: json['address'] as String,
      description: json['description'] as String,
      userId: (json['userId'] as num).toInt(),
      people: (json['people'] as num).toInt(),
    );

Map<String, dynamic> _$EventModelToJson(EventModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'status': instance.status,
      'price': instance.price,
      'categoryId': instance.categoryId,
      'categoryName': instance.categoryName,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'address': instance.address,
      'description': instance.description,
      'userId': instance.userId,
      'people': instance.people,
    };
