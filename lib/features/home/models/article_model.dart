import 'package:cloud_firestore/cloud_firestore.dart';

class ArticleModel {
  final String title;
  final String content;
  final String photoURL;
  final DateTime time;

  ArticleModel({
    required this.title,
    required this.content,
    required this.photoURL,
    required this.time,
  });

  // Создание Article из Firestore DocumentSnapshot
  factory ArticleModel.fromFireStore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return ArticleModel(
      title: data['title'] ?? '', // Проверка на null, если поле не заполнено
      content: data['content'] ?? '',
      photoURL: data['photo'] ?? '',
      time: (data['Date'] as Timestamp).toDate(), // Преобразование Timestamp в DateTime
    );
  }
}
