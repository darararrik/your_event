import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
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
    context.read<AuthBloc>().add(CheckLoginStatus());
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          FlutterNativeSplash.remove();
          context.router.replaceAll([MainRoute()]);
        } else if (state is Unauthenticated) {
          FlutterNativeSplash.remove();
          context.router.replaceAll([StartRoute()]);
        }
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              logo,
              const SizedBox(height: 28),
              successPicture,
              const SizedBox(height: 28),
              Text(
                "Все для праздника в одном месте",
                style: theme.textTheme.titleMedium,
              ),
              const SizedBox(height: 40),
              Expanded(
                child: ButtonWidget(
                  text: 'Создать аккаунт',
                  onPressed: () {
                    context.router.push(SignUpRoute()); // Используем AutoRoute
                  },
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ButtonWidget(
                  text: 'Войти',
                  onPressed: () {
                    context.router.push(
                        SignInRoute()); // Используем AutoRouteем pushNamed
                  },
                  hasColor: false,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
