import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourevent/blocs/auth.dart';
import 'package:yourevent/design/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Unauthenticated)
          {
             Navigator.pushReplacementNamed(context, '/start');
          }
        },
        builder: (context, state) {
          return Center(
            child: ElevatedButton(
              onPressed: () {
                context.read<AuthBloc>().add(SignOutRequested());
              },
              child: const Text(
                'Logout',
                style: TextStyle(color: black),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.white,
        selectedIndex: currentPageIndex,
        onDestinationSelected: (int index)
        {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: primaryBlack,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home_outlined,color: Colors.white,size: 32,),
            icon: Icon(Icons.home_outlined,color: secondaryGray,size: 32,),
            label: 'Главная',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.filter_none_outlined,color: Colors.white,),
            icon: Icon(Icons.filter_none_outlined,color: secondaryGray),
            label: 'Агентства',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.calendar_month_outlined, color: Colors.white,),
            icon: Icon(Icons.calendar_month_outlined,color: secondaryGray,),
            label: 'Мои события',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.person_outlined, color: Colors.white,),
            icon: Icon(Icons.person_outlined,color: secondaryGray,),
            label: 'Профиль',
          ),
        ],

      ),
    );
  }
}
