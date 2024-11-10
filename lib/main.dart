import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yourevent/api/your_event_client.dart';
import 'package:yourevent/core/internal/app_config.dart';
import 'package:yourevent/core/internal/firebase_options.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'core/internal/your_event_app.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
 
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await _initPrefs();
  await dotenv.load(fileName: ".env");
  final client = YourEventClient.create(apiUrl: dotenv.env['API_URL']);
  await initializeDateFormatting('ru, null');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final config = AppConfig(preferences: prefs, apiClient: client);
  runApp(YourEventApp(
    config: config,
  ));
}

Future<SharedPreferences> _initPrefs() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs;
}
