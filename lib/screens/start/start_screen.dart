import 'package:flutter/material.dart';
import 'package:yourevent/core/widgets/buttonForm.dart';
import 'package:yourevent/design/images.dart';
import 'package:yourevent/screens/signIn/signIn_screen.dart';
// Ваши состояния

class StartScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 52, 16, 0),
        child: Column(
          children: [
            logo,
            SizedBox(height: 60,),
            Text(
                'Все для праздника\nв одном месте',
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineMedium,
              ),
            SizedBox(height: 32,),

            imgStartScreen,
            SizedBox(height: 40,),

            ButtonForm(
              text: 'Создать аккаунт',
              onPressed: () {
                Navigator.pushNamed(context, '/signUp');
              },
            ),
            const SizedBox(
              height: 20,
            ),
            ButtonForm(
              text: 'Войти',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignInScreen()),
                );
              },
              hasColor: false,
            ),
          ],
        ),
      ),
    );
  }
}
