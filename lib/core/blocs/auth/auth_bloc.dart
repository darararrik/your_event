import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'dart:async';
import 'package:yourevent/core/data/repositories/repositories.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc(this._authRepository) : super(AuthInitial()) {
    //on<AuthCheckRequested>(_onAuthCheckRequested);
    on<SignInRequested>(_onSignInRequested);
    //on<SignOutRequested>(_onSignOutRequested);
    on<SignUpRequested>(_onSignUpRequested);
  }

  Future<void> _onSignUpRequested(
      SignUpRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final userRequestRegister = RegisterRequestDto(
          email: event.email,
          name: event.name,
          surname: event.surname,
          password: event.password);
      await _authRepository.singUp(userRequestRegister);
      emit(const AuthSuccess());
    } catch (e) {
      emit(const AuthErrorState(error: 'Ошибка при регистрации.'));
    }
  }

  Future<void> _onSignInRequested(
      SignInRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final loginRequest =
          LoginRequestDto(email: event.email, password: event.password);
      await _authRepository.signIn(loginRequest);
      emit(const AuthSuccess());
    } catch (e) {
      emit(const AuthErrorState(error: 'Ошибка при авторизации.'));
    }
  }
}
