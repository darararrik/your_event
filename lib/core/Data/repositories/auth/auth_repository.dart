import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yourevent/api/your_event_client.dart';
import 'package:yourevent/api/models/auth_request.dart';
import 'package:yourevent/api/models/auth_response.dart';

class AuthRepository {
  AuthRepository({required this.client, required this.prefs});

  final YourEventClient client;
  final SharedPreferences prefs;

  Future<AuthResponse> register({
    required String name,
    required String surname,
    required String email,
    required String password,
  }) async {
    final request = AuthRequest(
      email: email,
      password: password,
      name: name,
      surname: surname,
    );
    final response = await client.register(request);
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
