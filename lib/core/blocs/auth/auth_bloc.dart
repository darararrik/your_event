import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yourevent/core/data/api/token_service/token_interface_service.dart';
import 'package:yourevent/core/data/repositories/auth/auth_interface_repository.dart';
import 'package:yourevent/core/data/repositories/models/login_request/login_request_dto.dart';
import 'package:yourevent/core/data/repositories/models/register_request/register_request_dto.dart';
import 'dart:async';
import 'package:yourevent/core/data/repositories/user/user_interface_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthRepository _authRepository;
  final ITokenService _tokenService;
  final IUserRepository _userRepository;

  AuthBloc(this._authRepository, this._tokenService, this._userRepository)
      : super(AuthInitial()) {
    on<CheckLoginStatus>(_onCheckLoginStatus);
    on<SignInRequested>(_onSignInRequested);
    on<SignOutRequested>(_onSignOutRequested);
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
      await _authRepository.signUp(userRequestRegister);
      emit(const Authenticated());
    } catch (e) {
      emit(const AuthErrorState(error: 'Ошибка при регистрации.'));
    }
  }

  Future<void> _onCheckLoginStatus(
      CheckLoginStatus event, Emitter<AuthState> emit) async {
    final accessToken = _tokenService.getAccessToken();

    if (accessToken != null) {
      final isValid = await _validateToken(accessToken);
      if (isValid) {
        emit(Authenticated());
      } else {
        emit(Unauthenticated());
      }
    } else {
      emit(Unauthenticated());
    }
  }

  Future<bool> _validateToken(String token) async {
    try {
      await _userRepository.getCurrentUser();
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<void> _onSignInRequested(
      SignInRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final loginRequest =
          LoginRequestDto(email: event.email, password: event.password);
      await _authRepository.signIn(loginRequest);
      emit(const Authenticated());
    } catch (e) {
      emit(const AuthErrorState(error: 'Ошибка при авторизации.'));
    }
  }

  FutureOr<void> _onSignOutRequested(
      SignOutRequested event, Emitter<AuthState> emit) async {
    await _authRepository.logout();
    emit(Unauthenticated());
  }
}
