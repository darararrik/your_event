import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yourevent/features/home/data/models/article_model.dart';

class ArticlesRepository {
  final FirebaseFirestore _firestore;

  ArticlesRepository(this._firestore);

  Future<List<ArticleModel>> fetchArticles() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await _firestore.collection('articles').get();

      return snapshot.docs
          .map((doc) => ArticleModel.fromFireStore(doc))
          .toList();
    } catch (e) {
      throw Exception('Error fetching articles: $e');
    }
  }
}

