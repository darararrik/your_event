import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yourevent/core/Data/data.dart';
import 'package:yourevent/core/blocs/auth/auth_bloc.dart';
import 'package:yourevent/core/blocs/event_type/event_type_bloc.dart';
import 'package:yourevent/core/internal/app_config.dart';
import 'package:yourevent/core/utils/theme.dart';
import 'package:yourevent/features/account/presentation/bloc/account_bloc.dart';
import 'package:yourevent/features/create_event/Presentation/bloc/create_event/create_event_bloc.dart';
import 'package:yourevent/features/home/data/article_repository/articles_repository.dart';
import 'package:yourevent/features/home/Presentation/bloc/articles_bloc.dart';
import 'package:yourevent/features/my_events/Presentation/blocs/my_events/my_events_bloc.dart';
import 'package:yourevent/features/profile_screens/profile/Presentation/bloc/profile_bloc.dart';
import 'package:yourevent/router/router.dart';

class YourEventApp extends StatelessWidget {
  final _router = AppRouter();

  YourEventApp({super.key, required this.config});
  final AppConfig config;

  @override
  Widget build(BuildContext context) {
    final AuthRepository authRepository = AuthRepository(
      prefs: config.preferences,
      apiService: config.apiService,
    );

    final EventRepository eventRepository = EventRepository(
      apiService: config.apiService,
    );

    // Проверка токенов при запуске
    _checkLoginStatus(context, config.preferences);

    return MultiBlocProvider(
      providers: [
        BlocProvider<EventTypeBloc>(
          create: (context) => EventTypeBloc(eventRepository),
        ),
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(authRepository),
        ),
        BlocProvider<CreateEventBloc>(
            create: (context) => CreateEventBloc(
                eventRepository: eventRepository,
                apiService: config.apiService)),
        BlocProvider<MyEventsBloc>(
          create: (context) => MyEventsBloc(eventRepository),
        ),
      ],
      child: MaterialApp.router(
        theme: lightTheme,
        routerConfig: _router.config(),
      ),
    );
  }

  Future<void> _checkLoginStatus(
      BuildContext context, SharedPreferences preferences) async {
    final accessToken = preferences.getString('accessToken');
    if (accessToken != null) {
      final isValid = await _validateToken(accessToken);
      if (isValid) {
        _router.replaceAll([const MainRoute()]);
      } else {
        _router.replaceAll([const StartRoute()]);
      }
    } else {
      _router.replaceAll([const StartRoute()]);
    }
  }

  Future<bool> _validateToken(String token) async {
    try {
      final response = await config.apiService.getCurrentUser();
      return response != null;
    } catch (e, stacktrace) {
      print("Token validation failed: $e\n$stacktrace");
      return false;
    }
  }
}
