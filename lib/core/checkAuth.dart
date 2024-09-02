import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourevent/blocs/auth/auth_bloc.dart';

// В AuthScreen


class CheckAuth extends StatelessWidget {
  const CheckAuth({super.key});

@override
Widget build(BuildContext context) {
  return BlocListener<AuthBloc, AuthState>(
    listener: (context, state) {
      if (state is AuthSuccess) {
        print('Navigating to /home');
        Navigator.pushReplacementNamed(context, '/home');
      } else if (state is Unauthenticated) {
        print('Navigating to /start');
        Navigator.pushReplacementNamed(context, '/start');
      }
    },
    child: const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    ),
  );
}
}
