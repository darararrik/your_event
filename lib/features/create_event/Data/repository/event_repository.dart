import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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

  Future<void> pushEventFirebase(EventModel eventData) async {
    // Логика сохранения события в Firebase
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('myEvents')
          .add({
        'name': eventData.name,
        'description': eventData.description,
        'date': eventData.date,
        'time': eventData.time.toString(),
        'numberOfPeople': eventData.numberOfPeople,
        'cost': eventData.price,
        'address': eventData.address,
      });
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('Ошибка: $e');

      // TODO
    }
  }
}
