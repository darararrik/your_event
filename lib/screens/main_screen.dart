import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Главный экран')),
      body: Center(child: Text('Добро пожаловать в главное приложение!')),
    );
  }
}
