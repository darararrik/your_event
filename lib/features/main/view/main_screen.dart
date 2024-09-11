import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourevent/core/blocs/auth/auth.dart';
import 'package:yourevent/core/widgets/widgets.dart';
import 'package:yourevent/router/router.dart';
import 'package:yourevent/features/features.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //final theme = Theme.of(context);
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Unauthenticated) {
          // Переход на стартовый экран при выходе пользователя
          context.router.replaceAll([const StartRoute()]);
        }
      },
      child: AutoTabsRouter(
        routes: const [
          HomeRoute(),
          AgentsRoute(),
          MyEventsRoute(),
          ProfileRoute(),
        ],
        builder: (context, child) {
          final tabsRouter = AutoTabsRouter.of(context);
          return Scaffold(
            body:
                child, // Используйте `child` для отображения содержимого ваших вкладок
            bottomNavigationBar: NavigationBarWidget(tabsRouter),
          );
        },
      ),
    );
  }
}
