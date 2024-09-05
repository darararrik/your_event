import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourevent/core/blocs/bottom_nav/bottom_nav_bloc.dart';
import 'package:yourevent/core/widgets/bottom_nav_custom.dart';
import 'package:yourevent/router/router.dart';
import 'package:yourevent/screens/screens.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
          body: child,
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: theme.primaryColor,
            unselectedItemColor: theme.hintColor,
            currentIndex: tabsRouter.activeIndex,
            onTap: (index) => _openPage(index , tabsRouter),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home), 
                label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.filter_none), 
                  label: 'Agents'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_month), 
                  label: 'MyEvents'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), 
                  label: 'Profile'),
            ],
          ),
        );
      },
    );
  }

  void _openPage(int index,TabsRouter tabsRouter) {
    tabsRouter.setActiveIndex(index);
  }
}
