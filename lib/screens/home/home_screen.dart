import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
const HomeScreen({ super.key });

  @override
  Widget build(BuildContext context){
      return Scaffold(
      appBar: AppBar(title: Text('MainScreen'),
      centerTitle: true,),
      body: Center(child: Text('Welcome')), // Добавьте форму входа здесь
    );
  }
}