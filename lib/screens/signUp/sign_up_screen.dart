import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourevent/blocs/auth/auth_bloc.dart';
import 'package:yourevent/design/colors.dart';
import 'package:yourevent/core/widgets/widgets.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    String? errorPassword;
    String? errorEmail;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Регистрация',
          style: theme.textTheme.headlineMedium,
        ),
        centerTitle: true,
        backgroundColor: white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 48),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Registration Successful!')),
              );
              Navigator.pushReplacementNamed(context, '/home');
            } else if (state is AuthFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            }
          },
          builder: (context, state) {
            if (state is AuthErrorState) {
              errorEmail = state.emailError;
              errorPassword = state.passwordError;
            }
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormFieldCustom(
                    controller: nameController,
                    labelText: 'Имя пользователя',
                    hintText: "Light",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Введите имя пользователя';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  TextFormFieldCustom(
                    controller: emailController,
                    labelText: 'E-mail',
                    hintText: "Введите вашу почту",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Введите e-mail';
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'Введите корректный email';
                      }
                      return errorEmail;
                    },
                  ),
                  const SizedBox(height: 24),
                  TextFormFieldCustom(
                    controller: passwordController,
                    labelText: 'Пароль',
                    hintText: "Придумайте пароль",
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Введите пароль';
                      }
                      if (value.length < 6) {
                        return 'Пароль должен быть не менее 6 символов';
                      }
                      return errorPassword;
                    },
                  ),
                  const SizedBox(height: 40),
                  ButtonForm(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(
                              SignUpRequested(
                                name: nameController.text.trim(),
                                email: emailController.text.trim(),
                                password: passwordController.text.trim(),
                              ),
                            );
                      }
                    },
                    text: 'Зарегистрироваться',
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
