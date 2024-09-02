import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:yourevent/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthRepository {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  AuthRepository({firebase_auth.FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;
 static const String defaultAvatarUrl = 'gs://your-project-id.appspot.com/default-avatar.jpg'; // URL фото по умолчанию в Firebase Storage


  /// Регистрация нового пользователя с использованием email и пароля.
  Future<void> createUser({required String name,
      required String email, required String password}) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await userCredential.user?.updateDisplayName(name);

      
      final firebaseUser = userCredential.user!;
      // Обновляем профиль пользователя
      await firebaseUser.updateProfile(photoURL: defaultAvatarUrl);
      await _firestore.collection('users').doc(firebaseUser.uid).set({
        'name': name,
        'email': email,
        'avatarUrl': defaultAvatarUrl,
      });
    } on firebase_auth.FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      } else {
        print('Registration error: ${e.message}');
      }
    } catch (e) {
      print('An unknown error occurred: $e');
    }
  }

  /// Вход пользователя с использованием email и пароля.
  // Future<User?> signInWithEmailAndPassword(
  //     {required String email, required String password}) async {
  //   try {
  //     final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );
  //     print('User logged in: ${userCredential.user?.uid}');
  //     return User.fromFirebaseUser(userCredential.user!);
  //   } on firebase_auth.FirebaseAuthException catch (e) {
  //     if (e.code == 'user-not-found') {
  //       print('No user found for that email.');
  //     } else if (e.code == 'wrong-password') {
  //       print('Wrong password provided for that user.');
  //     } else {
  //       print('Login error: ${e.message}');
  //     }
  //   } catch (e) {
  //     throw Exception("Ошибка при входе: $e");
  //   }
  //   return null;
  // }
  //   /// Выход пользователя из системы.
  //   Future<void> signOut() async {
  //     await _firebaseAuth.signOut();
  //   }

    /// Получение текущего авторизованного пользователя.
    User? getCurrentUser() {
      final firebaseUser = _firebaseAuth.currentUser;
      if (firebaseUser != null) {
        return User.fromFirebaseUser(firebaseUser);
      }
      return null;
    }
  // // Отправка email для подтверждения
  //    Future<void> onVerifyEmail() async {
  //   try {
  //     await _firebaseAuth.currentUser?.sendEmailVerification();
  //     print('Verification email sent to ${_firebaseAuth.currentUser?.email}');
  //   } catch (e) {
  //     print('Failed to send verification email: $e');
  //   }
  // }


}
