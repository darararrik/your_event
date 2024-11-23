import 'dart:async';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:yourevent/core/data/api/your_event_client.dart';
import 'package:yourevent/core/data/repositories/models/agency/agency_dto.dart';
import 'package:yourevent/core/data/repositories/models/agency_service/agency_service_dto.dart';
import 'package:yourevent/core/data/repositories/models/user/update_name/update_name_request.dart';
import 'package:yourevent/core/data/repositories/models/user/update_password_request/update_password_request.dart';
import 'package:yourevent/core/data/repositories/repositories.dart';

class ApiService {
  final Dio _dio;
  final SharedPreferences _prefs;
  final YourEventClient _client;
  bool isRefreshing = false;
  List<void Function(String)> requestQueue = [];
  ApiService(this._dio, this._prefs, this._client) {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        // Добавляем токен авторизации в заголовок запроса
        final path = options.path;
        if (path != "auth/register" &&
            path != "auth/login" &&
            path != "auth/refresh") {
          final accessToken = getAccessToken();
          if (accessToken != null) {
            options.headers["Authorization"] = "Bearer $accessToken";
          }
        }
        return handler.next(options); // Далее запрос будет отправлен с токеном
      },
      onError: (DioException e, handler) async {
        if (e.response?.statusCode == 401) {
          debugPrint("Ошибка 401. Попытка обновить токен.");

          // Обновление токена (например, через refresh token)
          final refreshedToken = await refreshAccessToken();
          if (refreshedToken != null) {
            // После успешного обновления токена пробуем повторить запрос с новым токеном
            final requestOptions = e.requestOptions;
            requestOptions.headers["Authorization"] =
                "Bearer $refreshedToken"; // Новый токен в заголовке

            // Повторный запрос с обновленным токеном
            try {
              final response = await _dio.request(
                requestOptions.path,
                options: Options(
                  method: requestOptions.method,
                  headers: requestOptions.headers,
                  validateStatus: (status) => status != null && status < 500,
                ),
                data: requestOptions.data,
                queryParameters: requestOptions.queryParameters,
              );

              // Возвращаем результат успешного повторного запроса
              return handler.resolve(response);
            } catch (error) {
              return handler.reject(e); // Если повторный запрос не удался
            }
          } else {
            debugPrint("Не удалось обновить токен. Пользователь разлогинен.");
            return handler.reject(e); // Ошибка обновления токена
          }
        } else {
          // Если ошибка не 401, то просто передаем дальше
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
      final response = await _client.refreshAccessToken(refreshTokenDto);
      final newAccessToken = response.accessToken;
      final newRefreshToken = response.refreshToken;

      // Сохраняем новые токены
      _prefs.setString("accessToken", newAccessToken);
      _prefs.setString("refreshToken", newRefreshToken);

      debugPrint("Токен обновлен успешно.");
      return newAccessToken; // Возвращаем новый accessToken
    } catch (e) {
      debugPrint("Ошибка в процессе обновления токена: $e");
      return null;
    }
  }

  String? getRefreshToken() {
    return _prefs.getString('refreshToken');
  }

  String? getAccessToken() {
    return _prefs.getString('accessToken');
  }

  Future<AuthResponseDto> login(LoginRequestDto loginRequest) async {
    final response = await _client.login(loginRequest);
    // Сохраняем токены после успешного логина
    _prefs.setString('accessToken', response.accessToken);
    _prefs.setString('refreshToken', response.refreshToken);
    return response;
  }

  Future<AuthResponseDto> register(RegisterRequestDto registerRequest) async {
    final response = await _client.register(registerRequest);
    // Сохраняем токены после успешной регистрации
    _prefs.setString('accessToken', response.accessToken);
    _prefs.setString('refreshToken', response.refreshToken);
    return response;
  }

  // Пример запроса с авторизацией
  Future<UserDto> getCurrentUser() async {
    try {
      return await _client.getCurrentUser();
    } catch (e) {
      debugPrint("Ошибка при запросе текущего пользователя: $e");
      rethrow;
    }
  }

  Future<List<EventTypeDto>> getListCategories() async {
    final response = await _client.getListCategories();
    return response;
  }

  Future<int> createEvent(EventDto event) async {
    final response = await _client.createEvent(event);
    return response;
  }

  Future<List<EventDto>> getListEvents(int userId) async {
    final response = await _client.getListEvents(userId);
    return response;
  }

  Future<List<AgencyDto>> getListAgencies(int pageIndex) async {
    final response = await _client.getListAgencies(pageIndex);
    return response;
  }

  Future<List<AgencyServiceDto>> getListAgencyServicesById(int id) async {
    final response = await _client.getListAgencyServicesById(id);
    return response;
  }

  Future<List<AgencyServiceDto>> getAllAgencyServices() async {
    final response = await _client.getAllAgencyServices();
    return response;
  }

  Future<UserDto> updatePassword(
      {required String oldPassword, required String newPassword}) async {
    final response = await _client.updatePassword(UpdatePasswordRequest(
        oldPassword: oldPassword, newPassword: newPassword));
    return response;
  }

  Future<UserDto> updateName(
      {required String name, required String surname}) async {
    final response = await _client
        .updateName(UpdateNameRequest(name: name, surname: surname));
    return response;
  }
}
