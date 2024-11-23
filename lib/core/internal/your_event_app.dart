import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yourevent/core/blocs/blocs.dart';
import 'package:yourevent/core/data/repositories/agencies/agencies_repository.dart';
import 'package:yourevent/core/data/repositories/repositories.dart';
import 'package:yourevent/core/internal/app_config.dart';
import 'package:yourevent/core/utils/theme.dart';
import 'package:yourevent/features/event_screens/create_event/Presentation/bloc/create_event/create_event_bloc.dart';
import 'package:yourevent/features/event_screens/event/presentation/bloc/event/event_bloc.dart';
import 'package:yourevent/features/event_screens/service_selection/presentation/service/service_bloc.dart';
import 'package:yourevent/features/my_events/my_events.dart';
import 'package:yourevent/features/profile_screens/account/Presentation/bloc/account_bloc.dart';
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
    final AgenciesRepository agenciesRepository = AgenciesRepository(
      apiService: config.apiService,
    );

    final UserRepository userRepository = UserRepository(config.apiService);
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
        BlocProvider<ServiceBloc>(
          create: (context) => ServiceBloc(agenciesRepository),
        ),
        BlocProvider<EventBloc>(
          create: (context) => EventBloc(),
        ),
        BlocProvider<ProfileBloc>(
          create: (context) => ProfileBloc(userRepository),
        ),
        BlocProvider<AccountBloc>(
          create: (context) => AccountBloc(userRepository),
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
      await config.apiService.getCurrentUser();
      return true;
    } catch (e, stacktrace) {
      debugPrint("Token validation failed: $e\n$stacktrace");
      return false;
    }
  }
}
