import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yourevent/core/data/api/api_service.dart';
import 'package:yourevent/core/data/api/token_service/token_interface_service.dart';
import 'package:yourevent/core/data/repositories/repositories.dart';

class AuthRepository implements IAuthRepository {
  final ApiService apiService;
  final ITokenService _tokenService;
  AuthRepository(
    this.apiService,
    this._tokenService,
  );

  @override
  Future<AuthResponseDto> signUp(RegisterRequestDto registerRequest) async {
    try {
      final response = await apiService.register(registerRequest);
      await _tokenService.saveTokens(
          refreshToken: response.refreshToken,
          accessToken: response.accessToken);
      return response;
    } catch (e) {
      debugPrint("Ошибка при регистрации: $e");
      rethrow; // Пробрасываем дальше или возвращаем кастомное исключение
    }
  }

  @override
  Future<AuthResponseDto> signIn(LoginRequestDto loginRequest) async {
    try {
      final response = await apiService.login(loginRequest);
      await _tokenService.saveTokens(
          refreshToken: response.refreshToken,
          accessToken: response.accessToken);
      return response;
    } catch (e) {
      debugPrint("Ошибка при входе: $e");
      rethrow; // Или пробрасываем кастомное исключение
    }
  }

  /// Выход из системы
  @override
  Future<void> logout() async {
    await _tokenService.deleteTokens();
  }
}
