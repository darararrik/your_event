import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yourevent/features/home/bloc/articles_bloc.dart';
import 'package:yourevent/features/home/repository/articles_repository.dart';
import 'package:yourevent/features/profile/bloc/profile_bloc.dart';
import 'package:yourevent/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourevent/repositories/auth/auth_repository.dart';
import 'package:yourevent/features/features.dart';
import '../../core/blocs/auth/auth.dart';
import '../../core/design/design.dart';

class YourEventApp extends StatelessWidget {
  final _router = AppRouter();

  YourEventApp({super.key});
  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    AuthRepository authRepository = AuthRepository();
    ArticlesRepository articlesRepository = ArticlesRepository(firestore);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(authRepository),
        ),
        BlocProvider(
          create: (context) => ProfileBloc(authRepository),
        ),
        BlocProvider(create: (context) => ArticlesBloc(articlesRepository)..add(LoadArticles())),
      ],
      child: MaterialApp.router(
        theme: lightTheme,
        routerConfig: _router.config(),
      ),
    );
  }
}