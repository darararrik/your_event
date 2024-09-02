import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'dart:async';

import 'package:yourevent/repositories/auth/authRepository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc(this._authRepository) : super(AuthInitial()) {
    on<AuthCheckRequested>(_onAuthCheckRequested);
    // on<SignInRequested>(_onSignInRequested);
    // on<SignOutRequested>(_onSignOutRequested);
    on<AuthSignUpRequested>(_onSignUpRequested);
  }

  void _onAuthCheckRequested(
      AuthCheckRequested event, Emitter<AuthState> emit) {
    final user = _authRepository.getCurrentUser();
    if (user != null) {
      emit(AuthSuccess());
    } else {
      emit(Unauthenticated());
    }
  }

  // Future<void> _onSignInRequested(
  //     SignInRequested event, Emitter<AuthState> emit) async {
  //   try {
  //     final user = await _authRepository.signInWithEmailAndPassword(
  //         email: event.email, password: event.password);
  //     emit(AuthSuccess());
  //   } catch (e) {
  //     emit(AuthFailure(e.toString()));
  //   }
  // }

  // Future<void> _onSignOutRequested(
  //     SignOutRequested event, Emitter<AuthState> emit) async {
  //   await _authRepository.signOut();
  //   emit(Unauthenticated());
  // }

// Обработчик события регистрации
  Future<void> _onSignUpRequested(
      AuthSignUpRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      // Вызов метода регистрации из репозитория
      await _authRepository.createUser(
        name: event.name,
        email: event.email,
        password: event.password,
      );

      emit(const AuthSuccess()); // Переход в состояние аутентифицированного пользователя
    } catch (e) {
      emit(AuthFailure(e.toString())); // Переход в состояние ошибки
    }
  }
}
