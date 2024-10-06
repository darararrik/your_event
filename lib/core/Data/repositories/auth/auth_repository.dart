import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  AuthRepository({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;
  static const String defaultAvatarUrl =
      'https://firebasestorage.googleapis.com/v0/b/yourevent0app.appspot.com/o/avatar.png?alt=media&token=99be8cea-5607-441b-adc1-9c1df1d555ea'; // URL фото по умолчанию в Firebase Storage

  /// Регистрация нового пользователя с использованием email и пароля.
  Future<User?> createUser(
      {required String name,
      required String email,
      required String password}) async {
    try {
      // Регистрация пользователя в Firebase
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        throw FirebaseAuthException(
            message: 'Электронная почта уже используется.', code: e.code);
      } else if (e.code == 'weak-password') {
        throw FirebaseAuthException(message: 'Слабый пароль.', code: e.code);
      } else if (e.code == 'invalid-email') {
        throw FirebaseAuthException(
            message: 'Некорректный формат почты.', code: e.code);
      } else {
        throw FirebaseAuthException(
            message: 'Ошибка регистрации.', code: e.code);
      }
    } catch (e) {
      throw Exception('Произошла ошибка.');
    }
  }

  /// Сохранение данных пользователя в Firestore.
  Future<void> saveUserDataToFirestore({
    required String name,
    required String email,
  }) async {
    try {
      final firebaseUser = _firebaseAuth.currentUser;

      if (firebaseUser != null) {
        // Обновляем профиль пользователя
        await firebaseUser.updateDisplayName(name);
        await firebaseUser.updatePhotoURL(defaultAvatarUrl);

        // Сохраняем данные в Firestore
        await _firestore.collection('users').doc(firebaseUser.uid).set({
          'uid': firebaseUser.uid,
          'name': name,
          'email': email,
          'avatarUrl': defaultAvatarUrl,
        });
      } else {
        debugPrint('Ошибка: пользовательский объект null.');
      }
    } catch (e) {
      // Логируем ошибку, но не бросаем исключение, чтобы регистрация прошла успешно
      debugPrint('Ошибка при сохранении данных пользователя в Firestore: $e');
    }
  }

  // Вход пользователя с использованием email и пароля.
  Future<User?> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user!;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        throw FirebaseAuthException(
            message: 'Неправильный пароль.', code: e.code);
      }
      if (e.code == 'user-not-found') {
        throw FirebaseAuthException(
            message: 'Пользователь не найден.', code: e.code);
      }
      if (e.code == 'invalid-email') {
        throw FirebaseAuthException(
            message: 'Некорректный формат почты.', code: e.code);
      }
      if (e.code == 'too-many-requests') {
        throw FirebaseAuthException(message: 'Много запросов.', code: e.code);
      }
    } catch (e) {
      throw Exception('Произошла ошибка.');
    }
    return null;
  }

  /// Выход пользователя из системы.
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  /// Получение текущего авторизованного пользователя.
  Future<User?> getCurrentUser() async {
    final firebaseUser = _firebaseAuth.currentUser;
    if (firebaseUser != null) {
      return firebaseUser;
    }
    return null;
  }

  // Future<User> signInWithGoogle() async {
  //   try {
  //     // Trigger the authentication flow
  //     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  //     if (googleUser == null) {
  //       throw AuthException(emailError: 'Вход отменен пользователем.');
  //     }

  //     // Obtain the auth details from the request
  //     final GoogleSignInAuthentication googleAuth =
  //         await googleUser.authentication;

  //     // Create a new credential
  //     final credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth.accessToken,
  //       idToken: googleAuth.idToken,
  //     );

  //     // Once signed in, return the UserCredential
  //     final userCredential =
  //         await _firebaseAuth.signInWithCredential(credential);
  //     return userCredential.user!;
  //   } catch (e) {
  //     throw AuthException(emailError: 'Ошибка входа с помощью Google.');
  //   }
  // }
}
