import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:nested/nested.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yourevent/core/blocs/blocs.dart';
import 'package:yourevent/core/data/api/token_service/token_service.dart';
import 'package:yourevent/core/data/repositories/agencies/agencies_repository.dart';
import 'package:yourevent/core/data/repositories/repositories.dart';
import 'package:yourevent/core/internal/app_config.dart';
import 'package:yourevent/core/utils/theme.dart';
import 'package:yourevent/features/event_screens/create_event/presentation/bloc/create_event/create_event_bloc.dart';
import 'package:yourevent/features/event_screens/event/presentation/bloc/event/event_bloc.dart';
import 'package:yourevent/features/event_screens/service_selection/presentation/service/service_bloc.dart';
import 'package:yourevent/features/event_screens/my_events/my_events.dart';
import 'package:yourevent/features/profile_screens/account/presentation/bloc/change_name_bloc.dart';
import 'package:yourevent/features/profile_screens/change_email/presentation/bloc/change_email_bloc.dart';
import 'package:yourevent/features/profile_screens/change_password/Presentation/bloc/change_password_bloc.dart';
import 'package:yourevent/features/profile_screens/profile/presentation/bloc/profile_bloc.dart';
import 'package:yourevent/router/router.dart';

class YourEventApp extends StatelessWidget {
  YourEventApp({super.key, required this.config});
  final AppConfig config;
  final _router = AppRouter();

  @override
  Widget build(BuildContext context) {
    final AuthRepository authRepository =
        AuthRepository(config.apiService, TokenService(config.preferences));
    final EventRepository eventRepository =
        EventRepository(apiService: config.apiService);
    final AgenciesRepository agenciesRepository =
        AgenciesRepository(apiService: config.apiService);
    final UserRepository userRepository = UserRepository(config.apiService);
    return MultiBlocProvider(
      providers: [
      BlocProvider<EventTypeBloc>(
        create: (context) => EventTypeBloc(eventRepository),
      ),
      BlocProvider<AuthBloc>(
        create: (context) =>
            AuthBloc(authRepository, config.tokenService, userRepository),
      ),
      BlocProvider<CreateEventBloc>(
          create: (context) => CreateEventBloc(
              eventRepository: eventRepository, apiService: config.apiService)),
      BlocProvider<MyEventsBloc>(
        create: (context) => MyEventsBloc(eventRepository, userRepository),
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
      BlocProvider<ChangeNameBloc>(
        create: (context) => ChangeNameBloc(userRepository),
      ),
      BlocProvider<ChangeEmailBloc>(
        create: (context) => ChangeEmailBloc(userRepository),
      ),
      BlocProvider<ChangePasswordBloc>(
        create: (context) => ChangePasswordBloc(userRepository),
      ),
    ],
      child: MaterialApp.router(
        localizationsDelegates: [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: [
      const Locale('ru', 'RU'), // Русский
      const Locale('en', 'US'), // Английский
    ],
        theme: lightTheme,
        routerConfig: _router.config(),
      ),
    );
  }
}
