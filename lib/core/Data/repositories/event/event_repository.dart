import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:yourevent/core/Data/api/api_service.dart';
import 'package:yourevent/core/Data/repositories/event/event_interface_repository.dart';
import 'package:yourevent/core/Data/repositories/models/eventModel/event_model.dart';
import 'package:yourevent/core/Data/repositories/models/eventType/event_type_model.dart';
import 'package:yourevent/features/features.dart';

class EventRepository implements IEventRepository {
  final ApiService apiService;

  EventRepository({required this.apiService});

  @override
  Future<List<EventTypeModel>> getListEventType() async {
    final response = await apiService.getListCategories();
    return response;
  }

  @override
  Future<int> createEvent(EventModel eventData) async {
    final response = await apiService.createEvent(eventData);
    return response;
  }

  @override
  Future<List<EventModel>> getListEvents(int userId) async {
    final response = await apiService.getListEvents(userId);
    return response;
  }

}
