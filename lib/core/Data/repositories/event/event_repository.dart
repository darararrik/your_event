import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:yourevent/core/data/repositories/models/models.dart';
import 'package:yourevent/features/features.dart';

class EventRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  EventRepository(this._firestore);

  Future<List<EventTypeModel>> fetchEventTypesModel() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await _firestore.collection('eventTypes').get();

      return snapshot.docs
          .map((doc) => EventTypeModel.fromFireStore(doc))
          .toList();
    } catch (e) {
      throw Exception('Ошибка: $e');
    }
  }

  Future<List<EventModel>> fetchEvents() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
          .collection("users")
          .doc(_auth.currentUser!.uid)
          .collection("myEvents")
          .get();
      return snapshot.docs.map((doc) => EventModel.fromFireStore(doc)).toList();
    } catch (e) {
      throw Exception('Ошибка: $e');
    }
  }

  Future<void> pushEventFirebase(EventModel eventData) async {
    // Логика сохранения события в Firebase
    try {
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('myEvents')
          .doc(eventData.id)
          .set({
        'id': eventData.id,
        'name': eventData.name,
        'description': eventData.description,
        'date': (Timestamp.fromDate(eventData.date)),
        'numberOfPeople': eventData.numberOfPeople,
        'price': eventData.price,
        'address': eventData.address,
        'isCompleted': false,
      });
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('Ошибка: $e');

      // TODO
    }
  }

  checkDates(List<EventModel> events) async {
    DateTime now = DateTime.now();

    // Проверяем каждое событие
    for (var event in events) {
      if (event.date.isBefore(now) && event.isCompleted == false) {
        await _firestore
            .collection('users')
            .doc(_auth.currentUser!.uid)
            .collection("myEvents")
            .doc(event.id)
            .update({'isCompleted': true});
      }
    }
  }
}
