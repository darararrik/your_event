import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class EventModel {}

class EventTypeModel extends Equatable {
  final String name;
  final String imageUrl;
  const EventTypeModel({required this.name, required this.imageUrl});

  factory EventTypeModel.fromFireStore(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return EventTypeModel(
      name: data['type'],
      imageUrl: data['photoUrl'],
    );
  }

  @override
  List<Object?> get props => [name, imageUrl];
}
