// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tokes_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokesResponseDto _$TokesResponseDtoFromJson(Map<String, dynamic> json) =>
    TokesResponseDto(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
    );

Map<String, dynamic> _$TokesResponseDtoToJson(TokesResponseDto instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
    };
