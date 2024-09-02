import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourevent/blocs/auth/auth_bloc.dart';

// В AuthScreen


class CheckAuth extends StatelessWidget {
  const CheckAuth({super.key});

  @override
  Widget build(BuildContext context) {
    // Запросите начальное состояние авторизации при запуске экрана
    context.read<AuthBloc>().add(AuthCheckRequested());

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          // Перенаправление на экран главного контента после успешной авторизации
          Navigator.pushReplacementNamed(context, '/home');
        } else if (state is Unauthenticated) {
          // Перенаправление на экран входа в систему, если пользователь не авторизован
          Navigator.pushReplacementNamed(context, '/start');
        }
      },
      child: const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
    );
  }
}



