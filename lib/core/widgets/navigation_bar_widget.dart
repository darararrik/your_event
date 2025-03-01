import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../utils/utils.dart';

Container navigationBarWidget(TabsRouter tabsRouter) {
  return Container(
    height: 80,
    padding: const EdgeInsets.only(bottom: 20),
    decoration: const BoxDecoration(
      // Цвет фона контейнера, чтобы тень была заметна
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Color.fromRGBO(0, 0, 0, 0.1), // Цвет тени
          spreadRadius: 0,
          blurRadius: 15,
          offset: Offset(0, -3), // Смещение тени вверх
        ),
      ],
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(32), // Закругление для контейнера
      ),
    ),
    child: NavigationBar(
      backgroundColor: Colors.transparent, // Цвет самого NavigationBar
      selectedIndex: tabsRouter.activeIndex,
      onDestinationSelected: (index) => _openPage(index, tabsRouter),
      destinations: [
        NavigationDestination(
          icon: home,
          label: 'Home',
          selectedIcon: homeSelected,
        ),
        NavigationDestination(
          icon: chat,
          label: 'Chat',
          selectedIcon: chatSelected,
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
  );
}

void _openPage(int index, TabsRouter tabsRouter) {
  tabsRouter.setActiveIndex(index);
}
