import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourevent/core/blocs/auth/auth.dart';
import 'package:yourevent/core/utils/utils.dart';
import 'package:yourevent/core/widgets/widgets.dart';
import 'package:yourevent/features/profile_screens/account/presentation/bloc/account_bloc.dart';

import 'package:yourevent/router/router.dart';

@RoutePage()
class ChangeEmailScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  ChangeEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: BlocBuilder<AccountBloc, AccountState>(
        builder: (context, state) {
          if (state is AccountEmailUpdated) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 120),
              child: Column(
                children: [
                  emailCheck,
                  const SizedBox(
                    height: 40,
                  ),
                  Text(
                    "Осталось проверить почту",
                    style: theme.textTheme.headlineSmall,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    "Мы выслали письмо на почту. Перейдите по ней для авторизации.",
                    style: theme.textTheme.titleMedium!.copyWith(color: grey),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 48,
                  ),
                  ButtonWidget(
                      text: "Проверить почту",
                      onPressed: () async {
                        context.read<AuthBloc>().add(SignOutRequested());
                      })
                ],
              ),
            );
          }
          if (state is AccountLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return CustomScrollView(
            slivers: [
              const SliverAppBar(
                title: Text("Смена E-mail"),
                centerTitle: true,
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0)
                    .copyWith(top: 40),
                sliver: SliverFillRemaining(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "На новую почту будет выслана ссылка для подтверждения",
                          style: theme.textTheme.titleMedium,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        TextFieldWidget(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Введите новую почту!';
                            }
                            return null;
                          },
                          controller: emailController,
                          labelText: 'E-mail',
                          hintText: 'Введите новую почту',
                        ),
                        const SizedBox(height: 12),
                        TextFieldWidget(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Введите пароль';
                            }
                            return null;
                          },
                          controller: passwordController,
                          obscureText: true,
                          labelText: 'Пароль',
                          hintText: 'Введите пароль',
                        ),
                        const SizedBox(height: 24),
                        ButtonWidget(
                            text: "Далее",
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context
                                    .read<AccountBloc>()
                                    .add(AccountUpdateEmail(
                                      email: emailController.text.trim(),
                                      password: passwordController.text.trim(),
                                    ));
                              }
                            })
                      ],
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
