import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourevent/core/Presentation/blocs/auth/auth.dart';
import 'package:yourevent/core/Presentation/widgets/widgets.dart';
import 'package:yourevent/router/router.dart';
import 'package:yourevent/features/features.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //final theme = Theme.of(context);
    return AutoTabsRouter(
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
    );
  }
}
