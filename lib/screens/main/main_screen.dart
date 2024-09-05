import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourevent/core/blocs/bottom_nav/bottom_nav_bloc.dart';
import 'package:yourevent/core/widgets/bottom_nav_custom.dart';
import 'package:yourevent/screens/screens.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomNavBloc(),
      child: BlocBuilder<BottomNavBloc, BottomNavState>(
        builder: (context, state) {
          final currentIndex = (state as BottomNavInitial).currentIndex;

          return Scaffold(
            body: Navigator(
              onGenerateRoute: (settings) {
                switch (settings.name) {
                  case '/home':
                    return MaterialPageRoute(builder: (_) => HomeScreen());
                  case '/agents':
                    return MaterialPageRoute(builder: (_) => AgentsScreen());
                  case '/myEvents':
                    return MaterialPageRoute(builder: (_) => MyEventsScreen());
                   case '/profile':
                    return MaterialPageRoute(builder: (_) => ProfileScreen());
                }
              },
              initialRoute: '/home',
            ),
            bottomNavigationBar: CustomBottomNavBar(),
          );
        },
      ),
    );
  }
}