import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:yourevent/core/data/api/token_service/token_interface_service.dart';
import 'package:yourevent/core/data/api/your_event_client.dart';
import 'package:yourevent/core/data/repositories/models/agency/agency_dto.dart';
import 'package:yourevent/core/data/repositories/models/agency_service/agency_service_dto.dart';
import 'package:yourevent/core/data/repositories/models/user/update_email_request/update_email_request.dart';
import 'package:yourevent/core/data/repositories/models/user/update_name/update_name_request.dart';
import 'package:yourevent/core/data/repositories/models/user/update_password_request/update_password_request.dart';
import 'package:yourevent/core/data/repositories/repositories.dart';

class ApiService {
  final Dio _dio;
  final YourEventClient _client;
  bool isRefreshing = false;
  List<void Function(String)> requestQueue = [];
  Completer<void>? _refreshCompleter;
  final ITokenService _tokenService;
  ApiService(this._dio, this._client, this._tokenService) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Пропускаем запросы, которые не требуют авторизации
          final path = options.path;
          if (path != "auth/register" &&
              path != "auth/login" &&
              path != "auth/refresh") {
            final accessToken = _tokenService.getAccessToken();
            if (accessToken != null) {
              options.headers["Authorization"] = "Bearer $accessToken";
            }
          }
          return handler.next(options);
        },
        onError: (DioException e, handler) async {
          if (e.response?.statusCode == 401) {
            debugPrint("Ошибка 401. Запрос добавлен в очередь.");
            addToQueue((newToken) async {
              e.requestOptions.headers["Authorization"] = "Bearer $newToken";
              final response = await _dio.request(
                e.requestOptions.path,
                options: Options(
                  method: e.requestOptions.method,
                  headers: e.requestOptions.headers,
                ),
                data: e.requestOptions.data,
                queryParameters: e.requestOptions.queryParameters,
              );
              handler.resolve(response);
            });
            if (!isRefreshing) {
              try {
                await _handleTokenRefresh();
                final newAccessToken = _tokenService.getAccessToken();
                if (newAccessToken != null) {
                  processQueue(newAccessToken);
                }
              } catch (error) {
                handler.reject(e); // Если обновление токена не удалось
              }
            }
            return;
          }
          handler.next(e);
        },
      ),
    );
  }

  void addToQueue(void Function(String newToken) retryCallback) {
    requestQueue.add(retryCallback);
  }

  void processQueue(String newAccessToken) {
    for (var callback in requestQueue) {
      callback(newAccessToken);
    }
    requestQueue.clear();
  }


  Future<void> _handleTokenRefresh() async {
    if (isRefreshing) {
      debugPrint("Токен уже обновляется, ожидаем завершения.");
      await _refreshCompleter?.future; // Ожидаем завершения текущего обновления
      return;
    }

    isRefreshing = true;
    _refreshCompleter = Completer();

    try {
      final refreshToken = _tokenService.getRefreshToken();
      if (refreshToken == null) {
        throw Exception("Refresh токен отсутствует.");
      }

      final refreshTokenDto =
          RefreshTokenRequestDto(refreshToken: refreshToken);
      final response = await _client.refreshAccessToken(refreshTokenDto);

      // Сохраняем новые токены
      await _tokenService.saveTokens(
          accessToken: response.accessToken,
          refreshToken: response.refreshToken);

      debugPrint("Токен успешно обновлен.");
      _refreshCompleter?.complete();
    } catch (error) {
      debugPrint("Ошибка обновления токена: $error");
      await _tokenService.deleteTokens(); // Удаляем токены
      _refreshCompleter?.completeError(error);
      rethrow; // Пробрасываем ошибку для обработки
    } finally {
      isRefreshing = false;
      _refreshCompleter = null;
    }
  }

  Future<String?> refreshAccessToken() async {
    try {
      final refreshToken =
          _tokenService.getRefreshToken(); // Достаем refreshToken
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
      await _tokenService.saveTokens(
          accessToken: newAccessToken, refreshToken: newRefreshToken);

      debugPrint("Токен обновлен успешно.");
      return newAccessToken; // Возвращаем новый accessToken
    } catch (e) {
      debugPrint("Ошибка в процессе обновления токена: $e");
      return null;
    }
  }

  Future<AuthResponseDto> login(LoginRequestDto loginRequest) async {
    final response = await _client.login(loginRequest);
    // Сохраняем токены после успешного логина
    _saveTokens(response);
    return response;
  }

  Future<AuthResponseDto> register(RegisterRequestDto registerRequest) async {
    final response = await _client.register(registerRequest);
    // Сохраняем токены после успешной регистрации
    _saveTokens(response);

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

  Future<AuthResponseDto> updatePassword(
      {required String oldPassword, required String newPassword}) async {
    final response = await _client.updatePassword(UpdatePasswordRequest(
        oldPassword: oldPassword, newPassword: newPassword));
    _saveTokens(response);

    return response;
  }

  Future<UserDto> updateName(
      {required String name, required String surname}) async {
    final response = await _client
        .updateName(UpdateNameRequest(name: name, surname: surname));
    return response;
  }

  Future<AuthResponseDto> updateEmail({required String newEmail}) async {
    final response =
        await _client.updateEmail(UpdateEmailRequest(newEmail: newEmail));
    _saveTokens(response);
    return response;
  }

  Future<void> _saveTokens(AuthResponseDto response) async {
    await _tokenService.saveTokens(
      accessToken: response.accessToken,
      refreshToken: response.refreshToken,
    );
  }
}
