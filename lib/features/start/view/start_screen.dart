
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourevent/core/blocs/auth/auth_bloc.dart';
import 'package:yourevent/core/widgets/button_widget.dart';
import 'package:yourevent/router/router.dart';
import '../../../core/utils/utils.dart';

@RoutePage()
class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Отправляем событие для проверки аутентификации при загрузке экрана
    //context.read<AuthBloc>().add(AuthCheckRequested());
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          // Если пользователь авторизован, перенаправляем на главную страницу
              context.router.replaceAll([const MainRoute()]);
        }
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.fromLTRB(16, 52, 16, 0),
          child: Column(
            children: [
              logo,
              const SizedBox(height: 60),
              Text(
                'Все для праздника\nв одном месте',
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineSmall,
              ),
              const SizedBox(height: 32),
              imgStartScreen,
              const SizedBox(height: 40),
              ButtonWidget(
                text: 'Создать аккаунт',
                onPressed: () {
                  context.router.push(SignUpRoute()); // Используем AutoRoute
                },
              ),
              const SizedBox(height: 20),
              ButtonWidget(
                text: 'Войти',
                onPressed: () {
                  context.router
                      .push(SignInRoute()); // Используем AutoRouteем pushNamed
                },
                hasColor: false,
              ),
            
            ],
          ),
        ),
      ),
    );
  }
}
