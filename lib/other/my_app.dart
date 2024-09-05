import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourevent/repositories/auth/auth_repository.dart';
import 'package:yourevent/screens/screens.dart';

import '../core/blocs/auth/auth.dart';
import '../core/design/design.dart';

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
          '/main': (context) => MainScreen(),
          '/profile': (context) => ProfileScreen(),
          '/agents': (context) => AgentsScreen(),
          '/myEvents': (context) => MyEventsScreen(),
          '/home': (context) => const HomeScreen(),
          '/start': (context) => const StartScreen(),
          '/start/signUp': (context) => const SignUpScreen(),
          '/start/signIn': (context) => const SignInScreen(),
          '/checkAuth': (context) => const CheckAuth(),
        },
      ),
    );
  }
}
