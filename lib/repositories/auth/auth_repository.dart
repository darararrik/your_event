import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yourevent/core/models/user_model.dart' as user_model;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  AuthRepository({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;
  static const String defaultAvatarUrl =
      'gs://yourevent0app.appspot.com/avatar.png'; // URL фото по умолчанию в Firebase Storage

  /// Регистрация нового пользователя с использованием email и пароля.
  Future<user_model.User?> createUser(
      {required String name,
      required String email,
      required String password}) async {
    try {
      // Регистрация пользователя в Firebase
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Сохранение данных пользователя в Firestore
      await _saveUserDataToFirestore(
          userCredential: userCredential, name: name, email: email);

      return user_model.User.fromFirebaseUser(userCredential.user!);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        throw AuthException(emailError: 'Электронная почта уже используется.');
      } else if (e.code == 'weak-password') {
        throw AuthException(passwordError: 'Слабый пароль.');
      } else if (e.code == 'invalid-email') {
        throw AuthException(emailError: 'Некорректный формат почты.');
      } else {
        throw AuthException(emailError: 'Ошибка регистрации.');
      }
    } catch (e) {
      throw AuthException(emailError: 'Произошла ошибка.');
    }
  }

  /// Сохранение данных пользователя в Firestore.
  Future<void> _saveUserDataToFirestore({
    required UserCredential userCredential,
    required String name,
    required String email,
  }) async {
    try {
      final firebaseUser = userCredential.user!;
      
      // Обновляем профиль пользователя
      await firebaseUser.updateDisplayName(name);
      await firebaseUser.updateProfile(photoURL: defaultAvatarUrl);

      // Сохраняем данные в Firestore
      await _firestore.collection('users').doc(firebaseUser.uid).set({
        'uid': firebaseUser.uid,
        'name': name,
        'email': email,
        'avatarUrl': defaultAvatarUrl,
      });
    } catch (e) {
      // Логируем ошибку, но не бросаем исключение, чтобы регистрация прошла успешно
      debugPrint('Ошибка при сохранении данных пользователя в Firestore: $e');
    }
  }

  // Вход пользователя с использованием email и пароля.
  Future<user_model.User?> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return user_model.User.fromFirebaseUser(userCredential.user!);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        throw AuthException(passwordError: 'Неправильный пароль.');
      } else if (e.code == 'user-not-found') {
        throw AuthException(emailError: 'Пользователь не найден.');
      } else if (e.code == 'invalid-email') {
        throw AuthException(emailError: 'Некорректный формат почты.');
      } else {
        throw AuthException(emailError: 'Ошибка аутентификации.');
      }
    } catch (e) {
      throw AuthException(emailError: 'Произошла ошибка.');
    }
  }

  /// Выход пользователя из системы.
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  /// Получение текущего авторизованного пользователя.
  Future<user_model.User?> getCurrentUser() async {
    final firebaseUser = _firebaseAuth.currentUser;
    if (firebaseUser != null) {
      return user_model.User.fromFirebaseUser(firebaseUser);
    }
    return null;
  }

  Future<user_model.User> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        throw AuthException(emailError: 'Вход отменен пользователем.');
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      final userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      return user_model.User.fromFirebaseUser(userCredential.user!);
    } catch (e) {
      throw AuthException(emailError: 'Ошибка входа с помощью Google.');
    }
  }
}

class AuthException implements Exception {
  final String? emailError;
  final String? passwordError;

  AuthException({this.emailError, this.passwordError});
}
