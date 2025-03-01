import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yourevent/core/data/api/api_service.dart';
import 'package:yourevent/core/data/api/token_service/token_service.dart';

class AppConfig {
  AppConfig({
    required this.tokenService,
    required this.preferences,
    required this.dio,
    required this.apiService,
  });

  final SharedPreferences preferences;
  final Dio dio;
  final ApiService apiService;
  final TokenService tokenService;
}
