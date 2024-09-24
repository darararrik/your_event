import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourevent/core/blocs/auth/auth_bloc.dart';
import 'package:yourevent/core/widgets/widgets.dart';
import 'package:yourevent/router/router.dart';

import '../../../core/ui/design.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
// ignore: must_be_immutable
class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? errorEmail;
  String? errorPassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Вход'),
        centerTitle: true,
        backgroundColor: white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 48),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              context.router.replaceAll([const MainRoute()]);
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
                  TextFormFieldWidget(
                    controller: emailController,
                    hintText: 'Введите вашу почту',
                    labelText: 'E-mail',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Введите e-mail';
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'Введите корректный e-mail';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  TextFormFieldWidget(
                    controller: passwordController,
                    hintText: 'Введите пароль',
                    labelText: 'Пароль',
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Введите пароль';
                      }
                      if (value.length < 6) {
                        return 'Пароль должен быть не менее 6 символов';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          // TODO: Сделать экран "Забыли пароль?"
                        },
                        child: const Text(
                          "Забыли пароль?",
                          style: TextStyle(
                              color: Color(0xFF939BAA),
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  ButtonWidget(
                    text: "Войти",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(
                              SignInRequested(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim(),
                              ),
                            );
                      }
                    },
                  ),
                  //   const SizedBox(height: 24),
                  //   ButtonForm(
                  //     text: "Войти c Google",
                  //     onPressed: () {
                  //       context.read<AuthBloc>().add(
                  //             SignInGoogleRequested(
                  //               email: emailController.text.trim(),
                  //               password: passwordController.text.trim(),
                  //             ),
                  //           );
                  //     },
                  //   ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
