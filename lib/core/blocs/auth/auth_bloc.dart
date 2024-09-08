import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:yourevent/core/models/user_model.dart' as user_model;
import 'dart:async';

import 'package:yourevent/repositories/auth/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc(this._authRepository) : super(AuthInitial()) {
    on<AuthCheckRequested>(_onAuthCheckRequested);
    on<SignInRequested>(_onSignInRequested);
    on<SignOutRequested>(_onSignOutRequested);
    on<SignUpRequested>(_onSignUpRequested);
    on<SignInGoogleRequested>(_onSignInGoogleRequested);
    on<ProfileLoad>(_onProfileLoad);
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

// Обработчик события регистрации
  Future<void> _onSignInRequested(
      SignInRequested event, Emitter<AuthState> emit) async {
    try {
      final user = await _authRepository.signInWithEmailAndPassword(
          email: event.email, password: event.password);
      emit(AuthSuccess(user!));
    } on AuthException catch (e) {
      // Используем отдельные ошибки для email и password
      emit(AuthErrorState(
          emailError: e.emailError, passwordError: e.passwordError));
    } catch (e) {
      emit(const AuthErrorState(emailError: 'Произошла ошибка.'));
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
    } on AuthException catch (e) {
      emit(AuthErrorState(
          emailError: e.emailError, passwordError: e.passwordError));
    } catch (e) {
      emit(const AuthErrorState(emailError: 'Произошла ошибка.'));
    }
  }

  FutureOr<void> _onSignInGoogleRequested(
      SignInGoogleRequested event, Emitter<AuthState> emit) async {
    try {
      final user = await _authRepository.signInWithGoogle();
      emit(AuthSuccess(user));
    } on AuthException catch (e) {
      // Используем отдельные ошибки для email и password
      emit(AuthErrorState(
          emailError: e.emailError, passwordError: e.passwordError));
    } catch (e) {
      emit(AuthErrorState(emailError: 'Произошла ошибка: ${e.toString()}'));
    }
  }
    Future<void> _onProfileLoad(
      ProfileLoad event, Emitter<AuthState> emit) async {
    emit(ProfileLoading());
    try {
      final user = await _authRepository.getCurrentUser();
      if (user != null) {
        emit(ProfileLoaded(user));
      } else {
        emit(ProfileError(message: "user not found"));
      }
    } catch (e) {
      emit(ProfileError(message: e.toString()));
    }
  }
}
