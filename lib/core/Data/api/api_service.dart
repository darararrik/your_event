import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:yourevent/core/data/api/your_event_client.dart';
import 'package:yourevent/core/data/repositories/models/agency/agency_dto.dart';
import 'package:yourevent/core/data/repositories/models/agency_service/agency_service_dto.dart';
import 'package:yourevent/core/data/repositories/repositories.dart';

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
          debugPrint("Получена ошибка 401. Попытка обновить токен.");

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
            debugPrint("Не удалось обновить токен.");
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
    try {
      final refreshToken = getRefreshToken(); // Достаем refreshToken
      if (refreshToken == null) {
        debugPrint("Refresh token отсутствует.");
        return null;
      }
      final refreshTokenDto =
          RefreshTokenRequestDto(refreshToken: refreshToken);

      // Выполняем запрос на обновление токена
      final response = await client.refreshAccessToken(refreshTokenDto);
      final newAccessToken = response.accessToken;
      final newRefreshToken = response.refreshToken;

      // Сохраняем новые токены
      prefs.setString("accessToken", newAccessToken);
      prefs.setString("refreshToken", newRefreshToken);

      debugPrint("Токен обновлен успешно.");
      return newAccessToken; // Возвращаем новый accessToken
    } catch (e) {
      debugPrint("Ошибка в процессе обновления токена: $e");
      return null;
    }
  }

  String? getRefreshToken() {
    return prefs.getString('refreshToken');
  }

  String? getAccessToken() {
    return prefs.getString('accessToken');
  }

  Future<AuthResponseDto> login(LoginRequestDto loginRequest) async {
    final response = await client.login(loginRequest);
    // Сохраняем токены после успешного логина
    prefs.setString('accessToken', response.accessToken);
    prefs.setString('refreshToken', response.refreshToken);
    return response;
  }

  Future<AuthResponseDto> register(RegisterRequestDto registerRequest) async {
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

  Future<List<EventTypeDto>> getListCategories() async {
    final response = await client.getListCategories();
    return response;
  }

  Future<int> createEvent(EventDto event) async {
    final response = await client.createEvent(event);
    return response;
  }

  Future<List<EventDto>> getListEvents(int userId) async {
    final response = await client.getListEvents(userId);
    return response;
  }

  Future<List<AgencyDto>> getListAgencies(int pageIndex) async {
    final response = await client.getListAgencies(pageIndex);
    return response;
  }

  Future<List<AgencyServiceDto>> getListAgencyServicesById(int id) async {
    final response = await client.getListAgencyServicesById(id);
    return response;
  }

  Future<List<AgencyServiceDto>> getAllAgencyServices() async {
    final response = await client.getAllAgencyServices();
    return response;
  }
}
