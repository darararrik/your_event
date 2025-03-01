// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_name_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateNameRequest _$UpdateNameRequestFromJson(Map<String, dynamic> json) =>
    UpdateNameRequest(
      name: json['name'] as String,
      surname: json['surname'] as String,
    );

Map<String, dynamic> _$UpdateNameRequestToJson(UpdateNameRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'surname': instance.surname,
    };
