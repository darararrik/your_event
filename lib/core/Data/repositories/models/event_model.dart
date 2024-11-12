// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';


class EventModel {
  String id;
  String name;
  String description;
  DateTime date;
  String? numberOfPeople;
  String? price;
  String? address;
  bool isCompleted;

  EventModel(
      {required this.id,
      required this.name,
      required this.description,
      required this.date,
      this.numberOfPeople,
      this.price,
      this.address,
      required this.isCompleted});

  // Создание EventModel из Firestore DocumentSnapshot
  factory EventModel.fromFireStore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return EventModel(
      id: data['id'] ?? '',
      name: data['name'] ?? '', // Проверка на null, если поле не заполнено
      date: (data['date'] as Timestamp).toDate(),
      description: data['description'] ?? '',
      price: data['price'] ?? '',
      address: data['address'] ?? '',
      isCompleted: data['isCompleted'] ?? '',
    );
  }

  Map<String, dynamic> toJson(EventModel model) {
    return {
      'name': model.name,
      'description': model.description,
      'date': model.date,
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
