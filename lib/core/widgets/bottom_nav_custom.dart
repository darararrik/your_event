import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourevent/core/blocs/bottom_nav/bottom_nav.dart';

class CustomBottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavBloc, BottomNavState>(
      builder: (context, state) {
        final currentIndex = (state as BottomNavInitial).currentIndex;
        return BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            context.read<BottomNavBloc>().add(BottomNavIndexChanged(index));
            // Навигация на основе индекса
            if (index == 0) {
              Navigator.pushNamed(context, '/home');
            } else if (index == 1) {
              Navigator.pushNamed(context, '/agents');
            } else if (index == 2) {
              Navigator.pushNamed(context, '/myEvents');
            } else if (index == 3) {
              Navigator.pushNamed(context, '/profile');
            }
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.filter_none), label: 'Agents'),
            BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month), label: 'MyEvents'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        );
      },
    );
  }
}
