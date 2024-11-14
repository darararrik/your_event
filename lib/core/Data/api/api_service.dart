import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:yourevent/core/data/api/apiModels/models.dart';
import 'package:yourevent/core/data/api/apiModels/refresh_token_request.dart';
import 'package:yourevent/core/data/api/your_event_client.dart';
import 'package:yourevent/core/data/repositories/models/models.dart';

class ApiService {
  final Dio dio;
  final SharedPreferences prefs;
  final YourEventClient client;
  bool isRefreshing = false;
  List<void Function(String)> requestQueue = [];

  ApiService(this.dio, this.prefs, this.client) {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        final path = options.path;
        if (path != "auth/register" && path != "auth/login") {
          final accessToken = getAccessToken();
          if (accessToken != null) {
            options.headers["Authorization"] = "Bearer $accessToken";
          }
        }
        return handler.next(options);
      },
      onResponse: (response, handler) {
        return handler.next(response);
      },
      onError: (DioException e, handler) async {
        if (e.response?.statusCode == 401 && !isRefreshing) {
          // Запускаем процесс обновления токена
          isRefreshing = true;
          print("Получен 401 ошибка. Попытка обновить токен.");

          final newAccessToken = await refreshAccessToken();
          isRefreshing = false;

          if (newAccessToken != null) {
            // Выполняем запросы из очереди с новым токеном
            for (var callback in requestQueue) {
              callback(newAccessToken);
            }
            requestQueue.clear();

            // Повторяем первоначальный запрос с новым токеном
            e.requestOptions.headers["Authorization"] =
                "Bearer $newAccessToken";
            final clonedRequest = await dio.request(
              e.requestOptions.path,
              options: Options(
                method: e.requestOptions.method,
                headers: e.requestOptions.headers,
              ),
            );
            return handler.resolve(clonedRequest);
          } else {
            print("Не удалось обновить токен.");
            return handler.reject(e);
          }
        } else if (e.response?.statusCode == 401 && isRefreshing) {
          // Если обновление токена уже выполняется, добавляем запрос в очередь
          requestQueue.add((newAccessToken) {
            e.requestOptions.headers["Authorization"] =
                "Bearer $newAccessToken";
            dio.request(
              e.requestOptions.path,
              options: Options(
                method: e.requestOptions.method,
                headers: e.requestOptions.headers,
              ),
            );
          });
          return;
        } else {
          return handler.next(e);
        }
      },
    ));
  }

  Future<String?> refreshAccessToken() async {
    var refreshToken = getRefreshToken();
    if (refreshToken == null) {
      print("Refresh token not found.");
      return null;
    }
    try {
      final refreshTokenRequest =
          RefreshTokenRequest(refreshToken: refreshToken);
      final response = await client.refreshAccessToken(refreshTokenRequest);

      final newAccessToken = response.accessToken;
      if (newAccessToken != null) {
        prefs.setString('accessToken', newAccessToken);
        return newAccessToken;
      } else {
        print("Не удалось обновить токен.");
        return null;
      }
    } catch (e) {
      print("Ошибка при обновлении токена: $e");
      return null;
    }
  }

  String? getRefreshToken() {
    return prefs.getString('refreshToken');
  }

  String? getAccessToken() {
    return prefs.getString('accessToken');
  }

  Future<AuthResponse> login(LoginRequest loginRequest) async {
    final response = await client.login(loginRequest);
    // Сохраняем токены после успешного логина
    prefs.setString('accessToken', response.accessToken);
    prefs.setString('refreshToken', response.refreshToken);
    return response;
  }

  Future<AuthResponse> register(RegisterRequest registerRequest) async {
    final response = await client.register(registerRequest);
    // Сохраняем токены после успешной регистрации
    prefs.setString('accessToken', response.accessToken);
    prefs.setString('refreshToken', response.refreshToken);
    return response;
  }

  Future<UserDto> getCurrentUser() async {
    final accessToken = getAccessToken();
    if (accessToken != null) {
      return await client.getCurrentUser('Bearer $accessToken');
    } else {
      throw Exception("No token found");
    }
  }
}
