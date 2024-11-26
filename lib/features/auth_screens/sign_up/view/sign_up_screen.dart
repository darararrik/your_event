import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourevent/core/blocs/blocs.dart';
import 'package:yourevent/core/utils/utils.dart';
import 'package:yourevent/core/widgets/widgets.dart';
import 'package:yourevent/router/router.dart';

@RoutePage()
class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Регистрация',
          style: theme.textTheme.headlineSmall,
        ),
        centerTitle: true,
        backgroundColor: white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 48),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is Authenticated) {
              context.router
                  .popUntil((route) => route.settings.name == MainRoute.name);
              context.router.push(const HomeRoute());
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFieldWidget(
                    controller: nameController,
                    labelText: 'Имя',
                    hintText: "Введите ваше имя",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Введите имя пользователя';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  TextFieldWidget(
                    controller: surnameController,
                    labelText: 'Фамилия',
                    hintText: "Введите вашу фамилию",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Введите фамилию пользователя';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  TextFieldWidget(
                    controller: emailController,
                    labelText: 'E-mail',
                    hintText: "Введите вашу почту",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Введите e-mail';
                      } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                          .hasMatch(value)) {
                        return 'Введите корректный email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  TextFieldWidget(
                    maxLines: 1,
                    controller: passwordController,
                    labelText: 'Пароль',
                    hintText: "Придумайте пароль",
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
                  const SizedBox(height: 40),
                  Expanded(
                    child: ButtonWidget(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(
                                SignUpRequested(
                                  name: nameController.text.trim(),
                                  surname: surnameController.text.trim(),
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                ),
                              );
                        }
                      },
                      text: 'Зарегистрироваться',
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
