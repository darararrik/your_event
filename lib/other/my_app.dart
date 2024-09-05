import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourevent/design/theme.dart';

import 'blocs/auth.dart';
import 'repositories/repositories.dart';
import 'screens/screens.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
      child: MaterialApp(
        theme: lightTheme,
        initialRoute: '/checkAuth', // Используем CheckAuth как начальный экран
        routes: {
          '/home': (context) => const HomeScreen(),
          '/start': (context) => const StartScreen(),
          '/start/signUp': (context) => SignUpScreen(),
          '/start/signIn': (context) => SignInScreen(),
          '/checkAuth': (context) => const CheckAuth(),
        },
      ),
    );
  }
}