import 'package:flutter/material.dart';
import 'package:yourevent/core/widgets/button_form_custom.dart';
import 'package:yourevent/screens/signIn/sign_in_screen.dart';

import '../../core/design/design.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 52, 16, 0),
        child: Column(
          children: [
            logo,
            const SizedBox(height: 60,),
            Text(
                'Все для праздника\nв одном месте',
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineMedium,
              ),
            const SizedBox(height: 32,),

            imgStartScreen,
            const SizedBox(height: 40,),

            ButtonForm(
              text: 'Создать аккаунт',
              onPressed: () {
                Navigator.pushNamed(context, '/start/signUp');
              },
            ),
            const SizedBox(
              height: 20,
            ),
            ButtonForm(
              text: 'Войти',
              onPressed: () {
               Navigator.pushNamed(context, '/start/signIn');
              },
              hasColor: false,
            ),
          ],
        ),
      ),
    );
  }
}
