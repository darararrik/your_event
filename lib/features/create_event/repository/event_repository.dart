import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yourevent/features/features.dart';

class EventRepository {
  final FirebaseFirestore _firestore;

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
}
