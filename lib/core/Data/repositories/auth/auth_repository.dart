import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yourevent/core/data/api/api_service.dart';
import 'package:yourevent/core/data/api/models/models.dart';
import 'package:yourevent/core/data/api/your_event_client.dart';


class AuthRepository {
  final ApiService apiService;
  AuthRepository({
    required this.client,
    required this.prefs,
    required this.apiService,
  });

  final YourEventClient client;
  final SharedPreferences prefs;

  // Выполняем запрос регистрации напрямую, без авторизации
  Future<AuthResponse> register(RegisterRequest registerRequest) async {
    final response = await client.register(registerRequest);
    await _saveTokens(response.accessToken, response.refreshToken);
    return response;
  }

  Future<AuthResponse> login(LoginRequest loginRequest) async {
    final response = await client.login(loginRequest);
    await _saveTokens(response.accessToken, response.refreshToken);
    return response;
  }

  Future<void> _saveTokens(String accessToken, String refreshToken) async {
    await prefs.setString('accessToken', accessToken);
    await prefs.setString('refreshToken', refreshToken);
  }

  Future<String?> getAccessToken() async {
    return prefs.getString('accessToken');
  }

  Future<String?> getRefreshToken() async {
    return prefs.getString('refreshToken');
  }
}
