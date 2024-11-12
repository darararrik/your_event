
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourevent/core/blocs/blocs.dart';
import 'package:yourevent/core/widgets/widgets.dart';
import 'package:yourevent/router/router.dart';

import '../../../../core/utils/utils.dart';


@RoutePage()
class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Вход'),
        centerTitle: true,
        backgroundColor: white,
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthErrorState) {
            // // Перепроверяем форму для отображения ошибки
            // _formKey.currentState!.validate();
          } else if (state is AuthSuccess) {
            // Если вход успешен, перенаправляем на главную страницу
            context.router.replaceAll([const MainRoute()]);
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            // Показываем индикатор загрузки, если идет процесс аутентификации
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // Если нет загрузки, показываем форму
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 48),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFieldWidget(
                    controller: emailController,
                    hintText: 'Введите вашу почту',
                    labelText: 'E-mail',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Введите e-mail';
                      } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                          .hasMatch(value)) {
                        return 'Введите корректный e-mail';
                      } else if (state is AuthErrorState) {
                        return state.error;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  TextFieldWidget(
                    controller: passwordController,
                    hintText: 'Введите пароль',
                    labelText: 'Пароль',
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Введите пароль';
                      } else if (value.length < 6) {
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
                      if (state is AuthErrorState) {
                        _formKey.currentState!.validate();
                      }
                         context.read<AuthBloc>().add(
                              SignInRequested(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim(),
                              ),
                            );
                      // if (_formKey.currentState!.validate()) {
                     
                      // }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
