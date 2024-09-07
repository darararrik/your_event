import 'package:auto_route/auto_route.dart';
import 'package:yourevent/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourevent/repositories/auth/auth_repository.dart';
import 'package:yourevent/features/features.dart';
import '../core/blocs/auth/auth.dart';
import '../core/design/design.dart';

class YourEventApp extends StatefulWidget {
  const YourEventApp({super.key});

  @override
  State<YourEventApp> createState() => _YourEventAppState();
}

class _YourEventAppState extends State<YourEventApp> {
  final _router = AppRouter();
  @override
  Widget build(BuildContext context) {
    AuthRepository authRepository = AuthRepository();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              AuthBloc(authRepository)..add(AuthCheckRequested()),
        ),
      ],
      child: MaterialApp.router(
        theme: lightTheme,
        routerConfig: _router.config(),
      ),
    );
  }
}
