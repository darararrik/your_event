import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yourevent/features/my_events/blocs/my_events/my_events_bloc.dart';
import 'package:yourevent/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourevent/core/Data/repositories/auth/auth_repository.dart';
import 'package:yourevent/features/features.dart';
import '../blocs/blocs.dart';
import '../data/repositories/event/event.dart';
import '../utils/ui.dart';

class YourEventApp extends StatelessWidget {
  final _router = AppRouter();

  YourEventApp({super.key});
  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    AuthRepository authRepository = AuthRepository();
    ArticlesRepository articlesRepository = ArticlesRepository(firestore);
    EventRepository eventRepository = EventRepository(firestore);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(authRepository),
        ),
        BlocProvider(
          create: (context) => ProfileBloc(authRepository),
        ),
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
}
