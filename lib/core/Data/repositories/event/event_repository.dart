import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:yourevent/core/data/api/api_service.dart';
import 'package:yourevent/core/data/repositories/repositories.dart';


class EventRepository implements IEventRepository {
  final ApiService apiService;

  EventRepository({required this.apiService});

  @override
  Future<List<EventTypeDto>> getListEventType() async {
    final response = await apiService.getListCategories();
    return response;
  }

  @override
  Future<int> createEvent(EventDto eventData) async {
    final response = await apiService.createEvent(eventData);
    return response;
  }

  @override
  Future<List<EventDto>> getListEvents(int userId) async {
    final response = await apiService.getListEvents(userId);
    return response;
  }

}
