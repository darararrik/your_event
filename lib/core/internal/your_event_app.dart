import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourevent/core/blocs/blocs.dart';
import 'package:yourevent/core/data/repositories/auth/auth.dart';
import 'package:yourevent/core/data/repositories/event/event.dart';
import 'package:yourevent/core/utils/utils.dart';
import 'package:yourevent/features/create_event/presentation/bloc/create_event/create_event_bloc.dart';
import 'package:yourevent/features/home/data/article_repository/articles_repository.dart';
import 'package:yourevent/features/home/presentation/bloc/articles_bloc.dart';
import 'package:yourevent/features/my_events/presentation/blocs/my_events/my_events_bloc.dart';
import 'package:yourevent/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:yourevent/router/router.dart';

class YourEventApp extends StatelessWidget {
  final _router = AppRouter();

  YourEventApp({super.key});
  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final AuthRepository authRepository = AuthRepository();
    final ArticlesRepository articlesRepository = ArticlesRepository(firestore);
    final EventRepository eventRepository = EventRepository(firestore);

    return MultiBlocProvider(
      providers: [
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
}
