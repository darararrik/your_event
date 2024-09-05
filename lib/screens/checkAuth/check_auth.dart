import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourevent/core/blocs/auth/auth_bloc.dart';

// В AuthScreen
class CheckAuth extends StatelessWidget {
  const CheckAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Unauthenticated) {
          // Перенаправление на экран входа в систему, если пользователь не авторизован
          Navigator.pushReplacementNamed(context, '/start');
        } else if (state is AuthSuccess) {
          // Перенаправление на экран главного контента после успешной авторизации
          Navigator.pushReplacementNamed(context, '/home');
        }
        else if (state is AuthFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)));
      }},
      child: Scaffold(
        body: BlocBuilder<AuthBloc, AuthState>(
          builder: (BuildContext context, AuthState state) {
            return const Center(child: Text('Загрузка...'));
          },
        ),
      ),
    );
  }
}
