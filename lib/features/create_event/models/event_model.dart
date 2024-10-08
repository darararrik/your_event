import 'dart:convert';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:yourevent/core/utils/ui.dart';

class EventModel {
  String name;
  String description;
  String time;
  DateTime date;
  String? numberOfPeople;
  String? price;
  String? address;

  EventModel({
    required this.name,
    required this.date,
    required this.description,
    required this.time,
    this.numberOfPeople,
    this.price,
    this.address,
  });

  // Создание EventModel из Firestore DocumentSnapshot
  factory EventModel.fromFireStore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return EventModel(
      name: data['title'] ?? '', // Проверка на null, если поле не заполнено
      date: (data['date'] != null)
          ? (data['date'] as Timestamp).toDate()
          : DateTime.now(), // или любое другое значение по умолчанию
      description: data['description'] ?? '',
      time: data['time'] ?? '',
      price: data['cost'] ?? '',
      address: data['address'] ?? '',
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
