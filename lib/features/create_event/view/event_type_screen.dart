import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class EventTypeScreen extends StatelessWidget {
  const EventTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator(),),
    );
  }
}
