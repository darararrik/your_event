import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourevent/blocs/auth/auth_bloc.dart';
import 'package:yourevent/design/colors.dart';
import 'package:yourevent/repositories/auth/authRepository.dart';
import 'package:yourevent/screens/home/home_screen.dart'; // Импортируем экран, на который нужно перейти
import '../../core/widgets/widgets.dart';

class SignUpScreen extends StatelessWidget {
  final AuthRepository authRepository = AuthRepository();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Регистрация',
          style: theme.textTheme.headlineMedium,
        ),
        centerTitle: true,
        backgroundColor: white,
      ),
      body: BlocProvider(
        create: (context) => AuthBloc(authRepository),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 48),
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Registration Successful!')),
                );
                // Навигация на другой экран после успешной регистрации
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              } else if (state is AuthFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.error)),
                );
              }
            },
            builder: (context, state) {
              if (state is AuthLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              return Column(
                children: [
                  TextFieldForm(
                    controller: nameController,
                    labelText: 'Имя пользователя',
                    hintText: "Light",
                  ),
                  const SizedBox(height: 24),
                  TextFieldForm(
                    controller: emailController,
                    labelText: 'Email',
                    hintText: "Введите вашу почту",
                  ),
                  const SizedBox(height: 24),
                  TextFieldForm(
                    controller: passwordController,
                    labelText: 'Пароль',
                    hintText: "Придумайте пароль",
                    obscureText: true,
                  ),
                  const SizedBox(height: 40),
                  ButtonForm(
                    text: "Зарегистрироваться",
                    onPressed: () {
                      final name = nameController.text;
                      final email = emailController.text;
                      final password = passwordController.text;
                      context.read<AuthBloc>().add(
                            AuthSignUpRequested(
                              name: name,
                              email: email,
                              password: password,
                            ),
                          );
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
