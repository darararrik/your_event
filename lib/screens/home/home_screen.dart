import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
const HomeScreen({ super.key });

  @override
  Widget build(BuildContext context){
      return Scaffold(
      appBar: AppBar(title: Text('Вход'),
      centerTitle: true,),
      body: Center(child: Text('Форма входа')), // Добавьте форму входа здесь
    );
  }
}