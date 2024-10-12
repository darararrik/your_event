// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class User {
  final String id;
  final String email;
  final String displayName;
  final String photoURL;
  final bool emailVerified;

  User({
    required this.id,
    required this.email,
    required this.displayName,
    required this.photoURL,
    required this.emailVerified,
  });

  // Создание User из FirebaseAuth User
  factory User.fromFirebaseUser(firebase_auth.User user) {
    return User(
      id: user.uid,
      email: user.email ?? '',
      displayName: user.displayName ?? '',
      photoURL: user.photoURL ?? '',
      emailVerified: user.emailVerified,
    );
  }

  // Преобразование User в JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'displayName': displayName,
      'photoURL': photoURL,
    };
  }
}
