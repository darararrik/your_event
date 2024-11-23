// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_name_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateNameRequest _$UpdateNameRequestFromJson(Map<String, dynamic> json) =>
    UpdateNameRequest(
      firstName: json['firstName'] as String,
      surname: json['surname'] as String,
    );

Map<String, dynamic> _$UpdateNameRequestToJson(UpdateNameRequest instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'surname': instance.surname,
    };
