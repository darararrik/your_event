import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:yourevent/core/core.dart';
import 'package:yourevent/core/widgets/input_widget.dart';

@RoutePage()
class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final oldPasswordController = TextEditingController();
    final newPasswordController1 = TextEditingController();
    final newPasswordController2 = TextEditingController();
    final theme = Theme.of(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(
              "Сброс пароля",
              style: theme.textTheme.headlineSmall,
            ),
            centerTitle: true,
          ),
          SliverFillRemaining(
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 48, 16, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        TextFieldWidget(
                          labelText: 'Старый пароль',
                          controller: oldPasswordController,
                          hintText: 'Введите пароль',
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Пожалуйста, введите старый пароль';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 24),
                        TextFieldWidget(
                          labelText: 'Новый пароль',
                          controller: newPasswordController1,
                          hintText: 'Придумайте пароль',
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Пожалуйста, введите новый пароль';
                            }
                            if (value.length < 8) {
                              return 'Пароль должен содержать минимум 8 символов';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 24),
                        TextFieldWidget(
                          labelText: 'Подтверждение пароля',
                          controller: newPasswordController2,
                          hintText: 'Введите пароль еще раз',
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Пожалуйста, подтвердите пароль';
                            }
                            if (value != newPasswordController1.text) {
                              return 'Пароли не совпадают';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24.0),
                      child: ButtonWidget(
                        text: "Сбросить пароль",
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            // Если форма валидна, обработать данные
                            final oldPassword =
                                oldPasswordController.text.trim();
                            final newPassword =
                                newPasswordController1.text.trim();



                            // // Очистить поля после успешного выполнения
                            // oldPasswordController.clear();
                            // newPasswordController1.clear();
                            // newPasswordController2.clear();
                            // ScaffoldMessenger.of(context).showSnackBar(
                            //   const SnackBar(
                            //       content: Text("Пароль успешно изменён")),
                            // );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
