import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourevent/design/theme.dart';

import 'blocs/auth.dart';
import 'repositories/repositories.dart';
import 'screens/screens.dart';


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc(AuthRepository())),
      ],
      child: MaterialApp(
        theme: lightTheme,
        home: const CheckAuth(), // Используйте CheckAuth как начальный экран
        routes: {
          '/home': (context) => const HomeScreen(),
          '/start': (context) => StartScreen(),
          '/signUp': (context) => SignUpScreen(),
          '/signIn': (context) => SignInScreen(),
        },
      ),
    );
  }
}
