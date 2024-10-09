// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'package:yourevent/core/utils/ui.dart';

class EventModel {
  String id;
  String name;
  String description;
  String time;
  DateTime date;
  String? numberOfPeople;
  String? price;
  String? address;
  bool isCompleted = false;
  

  EventModel({
     required this.id,
    required this.name,
    required this.description,
    required this.time,
    required this.date,
    this.numberOfPeople,
    this.price,
    this.address,
    this.isCompleted = false
  });

  // Создание EventModel из Firestore DocumentSnapshot
  factory EventModel.fromFireStore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return EventModel(
      name: data['name'] ?? '', // Проверка на null, если поле не заполнено
      date: (data['date'] as Timestamp).toDate(),

      description: data['description'] ?? '',
      time: data['time'] ?? '',
      price: data['price'] ?? '',
      address: data['address'] ?? '',
      isCompleted: data['isCompleted'] ?? '', id: 'id',
    );
  }

  Map<String, dynamic> toJson(EventModel model) {
    return {
      'name': model.name,
      'description': model.description,
      'date': model.date,
      'time': model.time,
      'price': model.price,
      'address': model.address,
      'isCompleted': model.isCompleted,
    };
  }
}

class EventTypeModel extends Equatable {
  final String name;
  final String imageUrl;
  const EventTypeModel({required this.name, required this.imageUrl});

  factory EventTypeModel.fromFireStore(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return EventTypeModel(
      name: data['name'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
    );
  }

  @override
  List<Object?> get props => [name, imageUrl];
}
