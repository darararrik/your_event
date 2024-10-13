import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../utils/utils.dart';

Container navigationBarWidget(TabsRouter tabsRouter) {
  return Container(
    decoration: const BoxDecoration(
      color: Colors.transparent,
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
        destinations: [
          NavigationDestination(
            icon: home,
            label: 'Home',
            selectedIcon: homeSelected,
          ),
          NavigationDestination(
            icon: agents,
            label: 'Agents',
            selectedIcon: agentsSelected,
          ),
          NavigationDestination(
            icon: myEvents,
            label: 'MyEvents',
            selectedIcon: myEventsSelected,
          ),
          NavigationDestination(
            icon: profile,
            label: 'Profile',
            selectedIcon: profileSelected,
          ),
        ],
      ),
    ),
  );
}

void _openPage(int index, TabsRouter tabsRouter) {
  tabsRouter.setActiveIndex(index);
}
