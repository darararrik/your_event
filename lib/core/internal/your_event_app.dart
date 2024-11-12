import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yourevent/core/data/api/your_event_client.dart';
import 'package:yourevent/core/blocs/blocs.dart';
import 'package:yourevent/core/data/data.dart';
import 'package:yourevent/core/internal/app_config.dart';
import 'package:yourevent/core/utils/utils.dart';
import 'package:yourevent/features/account/presentation/bloc/account_bloc.dart';
import 'package:yourevent/features/create_event/presentation/bloc/create_event/create_event_bloc.dart';
import 'package:yourevent/features/home/data/article_repository/articles_repository.dart';
import 'package:yourevent/features/home/presentation/bloc/articles_bloc.dart';
import 'package:yourevent/features/my_events/presentation/blocs/my_events/my_events_bloc.dart';
import 'package:yourevent/features/profile_screens/profile/presentation/bloc/profile_bloc.dart';
import 'package:yourevent/router/router.dart';
class YourEventApp extends StatelessWidget {
  final _router = AppRouter();

  YourEventApp({super.key, required this.config});
  final AppConfig config;

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final AuthRepository authRepository = AuthRepository(
      prefs: config.preferences,
      apiService: config.apiService,
    );
    final ArticlesRepository articlesRepository = ArticlesRepository(
      firestore,
    );
    final EventRepository eventRepository = EventRepository(
      firestore,
    );

    // Проверка токенов при запуске
    _checkLoginStatus(config.preferences);

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AccountBloc(authRepository)),
        BlocProvider(create: (context) => ProfileBloc(authRepository)),
        BlocProvider(create: (context) => AuthBloc(authRepository)),
        BlocProvider(create: (context) => ArticlesBloc(articlesRepository)),
        BlocProvider(create: (context) => CreateEventBloc(eventRepository)),
        BlocProvider(create: (context) => MyEventsBloc(eventRepository)),
      ],
      child: MaterialApp.router(
        theme: lightTheme,
        routerConfig: _router.config(),
      ),
    );
  }

Future<void> _checkLoginStatus(SharedPreferences preferences) async {
    final token = preferences.getString('accessToken');
    if (token != null) {
      final isValid = await _validateToken(token);
      if (isValid) {
        _router.replace(const HomeRoute());
      } else {
                _router.replace(const StartRoute());
      }
    } else {
      _router.replace(const StartRoute());
    }
  }

Future<bool> _validateToken(String token) async {
  try {
    final response = await config.apiService.getCurrentUser();
    return response != null;  // Токен действителен, если получен ответ
  } catch (e) {
    print("Token validation failed: $e");
    return false;  // Токен недействителен
  }
}
}
