import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourevent/core/widgets/input_widget.dart';
import 'package:yourevent/features/profile_screens/change_password/Presentation/bloc/change_password_bloc.dart';
import 'package:yourevent/lib.dart';

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
    context.read<ChangePasswordBloc>().add(ResetState());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Сброс пароля",
          style: theme.textTheme.headlineSmall,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0).copyWith(top: 80),
        child: BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
          builder: (context, state) {
            if (state is ChangePasswordSuccess) {
              return _successState(theme, context);
            }
            if (state is Loading) {
              return const Center(child: CircularProgressIndicator());
            }
            return Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      passwordResetPicture,
                      const SizedBox(
                        height: 36,
                      ),
                      Text(
                        "Придумайте пароль",
                        style: theme.textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "Введите старый пароль и новый",
                        style:
                            theme.textTheme.titleMedium!.copyWith(color: grey),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
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
                          if (value.length < 6) {
                            return 'Пароль должен содержать минимум 6 символов';
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
                    child: Expanded(
                      child: ButtonWidget(
                        text: "Сбросить пароль",
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            // Если форма валидна, обработать данные
                            final oldPassword = oldPasswordController.text.trim();
                            final newPassword =
                                newPasswordController1.text.trim();
                            context.read<ChangePasswordBloc>().add(
                                ChangePasswordRequested(
                                    oldPassword: oldPassword,
                                    newPassword: newPassword));
                          }
                        },
                      ),
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

  Column _successState(ThemeData theme, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            passwordResetPicture,
            const SizedBox(
              height: 36,
            ),
            Text(
              "Пароль сброшен",
              style: theme.textTheme.headlineSmall,
            ),
            const SizedBox(
              height: 12,
            ),
            Text("Ваш пароль был успешно изменен.",
                style: theme.textTheme.titleMedium!.copyWith(color: grey)),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 24.0),
          child: ButtonWidget(
              text: "Вернуться в профиль",
              onPressed: () {
                context.router.navigate(ProfileRoute());
              }),
        )
      ],
    );
  }
}
