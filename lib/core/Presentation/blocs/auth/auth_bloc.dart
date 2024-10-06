import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:yourevent/core/Domain/models/user_model.dart' as user_model;
import 'dart:async';

import 'package:yourevent/core/Data/repositories/auth/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc(this._authRepository) : super(AuthInitial()) {
    on<AuthCheckRequested>(_onAuthCheckRequested);
    on<SignInRequested>(_onSignInRequested);
    on<SignOutRequested>(_onSignOutRequested);
    on<SignUpRequested>(_onSignUpRequested);
    // on<SignInGoogleRequested>(_onSignInGoogleRequested);
  }

  Future<void> _onAuthCheckRequested(
      AuthCheckRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final user = await _authRepository.getCurrentUser();
    if (user != null) {
      emit(AuthSuccess(user));
    } else {
      emit(Unauthenticated());
    }
  }

  Future<void> _onSignOutRequested(
      SignOutRequested event, Emitter<AuthState> emit) async {
    await _authRepository.signOut();
    emit(Unauthenticated());
  }

  Future<void> _onSignInRequested(
      SignInRequested event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoading());
      final user = await _authRepository.signInWithEmailAndPassword(
          email: event.email, password: event.password);
      emit(AuthSuccess(user!));
    } on FirebaseAuthException catch (e) {
      emit(AuthErrorState(error: e.message));
    } catch (_) {
      emit(const AuthErrorState(error: "Произошла ошибка"));
    }
  }

  Future<void> _onSignUpRequested(
      SignUpRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await _authRepository.createUser(
        name: event.name,
        email: event.email,
        password: event.password,
      );
      emit(AuthSuccess(user!));
      await _authRepository.saveUserDataToFirestore(
        name: event.name,
        email: event.email,
      );
    } on FirebaseAuthException catch (e) {
      emit(AuthErrorState(error: e.message));
    } catch (e) {
      emit(const AuthErrorState(error: 'Произошла ошибка.'));
    }
  }

  // FutureOr<void> _onSignInGoogleRequested(
  //     SignInGoogleRequested event, Emitter<AuthState> emit) async {
  //   try {
  //     final user = await _authRepository.signInWithGoogle();
  //     emit(AuthSuccess(user));
  //   } on FirebaseAuthException catch (e) {
  //     // Используем отдельные ошибки для email и password
  //     emit(AuthErrorState(error: e));
  //   } catch (e) {
  //     emit(AuthErrorState(error: 'Произошла ошибка: ${e.toString()}'));
  //   }
  // }
}
