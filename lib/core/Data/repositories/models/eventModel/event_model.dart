import 'dart:convert';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'event_model.g.dart';

@JsonSerializable()
class EventModel {
  final int? id;
  final String name;
  final String? status;
  final int price;
  final int categoryId;
  final String? categoryName;
  final DateTime startDate;
  final DateTime endDate;
  final String address;
  final String description;
  final int userId;
  final int people;

  EventModel({
    this.categoryName,
    this.id,
    required this.name,
    this.status,
    required this.price,
    required this.categoryId,
    required this.startDate,
    required this.endDate,
    required this.address,
    required this.description,
    required this.userId,
    required this.people,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) =>
      _$EventModelFromJson(json);
  Map<String, dynamic> toJson() => _$EventModelToJson(this);
}
