import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yourevent/core/data/api/api_service.dart';
import 'package:yourevent/core/data/api/token_service/token_service.dart';
import 'package:yourevent/core/data/api/your_event_client.dart';
import 'package:yourevent/core/internal/app_config.dart';
import 'package:yourevent/core/internal/firebase_options.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'core/internal/your_event_app.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  final prefs = await _initPrefs();
  await dotenv.load(fileName: ".env");
  final dio = Dio(); // Создание экземпляра Dio
  final client =
      YourEventClient.create(dio: dio, apiUrl: dotenv.env['API_URL']);
  await initializeDateFormatting('ru, null');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final TokenService tokenService = TokenService(prefs);
  final apiService = ApiService(dio, client, tokenService);

  final config = AppConfig(
      preferences: prefs,
      dio: dio,
      apiService: apiService,
      tokenService: tokenService);

  runApp(YourEventApp(
    config: config,
  ));
}

Future<SharedPreferences> _initPrefs() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs;
}
