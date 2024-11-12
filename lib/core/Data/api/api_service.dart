import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:yourevent/core/data/api/apiModels/models.dart';
import 'package:yourevent/core/data/api/your_event_client.dart';
import 'package:yourevent/core/data/repositories/models/models.dart';

class ApiService {
  final Dio dio;
  final SharedPreferences prefs;
  final YourEventClient client;

  ApiService(this.dio, this.prefs, this.client);

  void init() {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = prefs.getString('accessToken');
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        handler.next(options);
      },
      onError: (DioException e, handler) async {
        if (e.response?.statusCode == 401) {
          // Обновление токена при необходимости
          final isRefreshed = await _refreshToken();
          if (isRefreshed) {
            // Повторный запрос после обновления токена
            final requestOptions = e.requestOptions;
            requestOptions.headers['Authorization'] =
                'Bearer ${prefs.getString('accessToken')}';
            final response = await dio.request(
              requestOptions.path,
              options: Options(
                method: requestOptions.method,
                headers: requestOptions.headers,
              ),
              data: requestOptions.data,
              queryParameters: requestOptions.queryParameters,
            );
            return handler.resolve(response);
          }
        }
        handler.next(e);
      },
    ));
  }

  Future<UserDto> getCurrentUser() async {
    final token = prefs.getString('accessToken');
    if (token != null) {
      return await client.getCurrentUser('Bearer $token');
    } else {
      throw Exception("No token found");
    }
  }

  Future<bool> _refreshToken() async {
    final refreshToken = prefs.getString('refreshToken');
    if (refreshToken == null) return false;

    try {
      final response =
          await dio.post('/auth/refresh', data: {'refreshToken': refreshToken});
      final newAccessToken = response.data['accessToken'];
      prefs.setString('accessToken', newAccessToken);
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<T> executeAuthorized<T>(Future<T> Function() request) async {
    try {
      return await request();
    } catch (e) {
      rethrow;
    }
  }

  Future<AuthResponse> login(LoginRequest loginRequest) async =>
      await client.login(loginRequest);

  Future<AuthResponse> register(RegisterRequest registerRequest) async =>
      await client.register(registerRequest);
}
