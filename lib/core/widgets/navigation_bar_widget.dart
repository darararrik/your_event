import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../ui/design.dart';

// ignore: non_constant_identifier_names
Container NavigationBarWidget(TabsRouter tabsRouter) {
  return Container(
    decoration: const BoxDecoration(
        border: Border(top: BorderSide(width: 1, color: outline_Grey))),
    child: NavigationBar(
      selectedIndex: tabsRouter.activeIndex,
      onDestinationSelected: (index) => _openPage(index, tabsRouter),
      destinations: const [
        NavigationDestination(
          icon: Icon(
            Icons.home_outlined,
            size: 32,
          ),
          label: 'Home',
          selectedIcon: Icon(
            Icons.home_outlined,
            color: orange,
            size: 32,
          ),
        ),
        NavigationDestination(
          icon: Icon(Icons.filter_none),
          label: 'Agents',
          selectedIcon: Icon(
            Icons.filter_none,
            color: orange,
          ),
        ),
        NavigationDestination(
          icon: Icon(
            Icons.calendar_month,
            size: 28,
          ),
          label: 'MyEvents',
          selectedIcon: Icon(
            Icons.calendar_month,
            size: 28,
            color: orange,
          ),
        ),
        NavigationDestination(
          icon: Icon(
            Icons.person_outline,
            size: 32,
          ),
          label: 'Profile',
          selectedIcon: Icon(
            Icons.person_outline,
            size: 32,
            color: orange,
          ),
        ),
      ],
    ),
  );
}

void _openPage(int index, TabsRouter tabsRouter) {
  tabsRouter.setActiveIndex(index);
}
