import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:yourevent/core/data/models/user_model.dart';
import 'dart:async';

import 'package:yourevent/core/data/repositories/auth/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc(this._authRepository) : super(AuthInitial()) {
    //on<AuthCheckRequested>(_onAuthCheckRequested);
    //on<SignInRequested>(_onSignInRequested);
    //on<SignOutRequested>(_onSignOutRequested);
    on<SignUpRequested>(_onSignUpRequested);
  }


  Future<void> _onSignUpRequested(
      SignUpRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      // Регистрируем пользователя и получаем ответ с токенами
      final response = await _authRepository.register(
        name: event.name,
        surname: event.surname,
        email: event.email,
        password: event.password,
      );

      // Создаем объект UserEntity
      final user = UserEntity(
        name: event.name,
        surname: event.surname,
        email: event.email,
      );

      // Возвращаем успешное состояние с UserEntity
      emit(AuthSuccess(user));
    } catch (e) {
      emit(const AuthErrorState(error: 'Ошибка при регистрации.'));
    }
  }
}
