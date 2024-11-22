import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yourevent/core/data/api/api_service.dart';
import 'package:yourevent/core/data/repositories/repositories.dart';


class AuthRepository implements IAuthRepository {
  final ApiService apiService;
  AuthRepository({
    required this.prefs,
    required this.apiService,
  });

  final SharedPreferences prefs;

  // Выполняем запрос регистрации напрямую, без авторизации
  @override

  Future<AuthResponseDto> singUp(RegisterRequestDto registerRequest) async {
    final response = await apiService.register(registerRequest);
    await saveTokens(response.accessToken, response.refreshToken);
    return response;
  }

  @override
  Future<AuthResponseDto> signIn(LoginRequestDto loginRequest) async {
    final response = await apiService.login(loginRequest);
    await saveTokens(response.accessToken, response.refreshToken);
    return response;
  }

  @override
  Future<void> saveTokens(String accessToken, String refreshToken) async {
    await prefs.setString('accessToken', accessToken);
    await prefs.setString('refreshToken', refreshToken);
  }

  @override
  Future<String?> getAccessToken() async {
    return prefs.getString('accessToken');
  }

  @override
  Future<String?> getRefreshToken() async {
    return prefs.getString('refreshToken');
  }
}
