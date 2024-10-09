import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../utils/utils.dart';


Container navigationBarWidget(TabsRouter tabsRouter) {
  return Container(
    decoration: const BoxDecoration(
      boxShadow: [
        BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.1),
            spreadRadius: 0,
            blurStyle: BlurStyle.normal,
            blurRadius: 15,
            offset: Offset(0, -3))
      ],
    ),
    child: ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      child: NavigationBar(
        elevation: 32,
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
    ),
  );
}

void _openPage(int index, TabsRouter tabsRouter) {
  tabsRouter.setActiveIndex(index);
}
