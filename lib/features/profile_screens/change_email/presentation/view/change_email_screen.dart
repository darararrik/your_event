import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourevent/core/blocs/auth/auth.dart';
import 'package:yourevent/core/utils/utils.dart';
import 'package:yourevent/core/widgets/widgets.dart';
import 'package:yourevent/features/profile_screens/change_email/presentation/bloc/change_email_bloc.dart';
import 'package:yourevent/features/profile_screens/profile/presentation/bloc/profile_bloc.dart';

import 'package:yourevent/router/router.dart';

@RoutePage()
class ChangeEmailScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  late final Object? error;
  final _formKey = GlobalKey<FormState>();
  ChangeEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ChangeEmailBloc>().add(ResetState());
    final theme = Theme.of(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text("Смена E-mail"),
            centerTitle: true,
          ),
          SliverPadding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0).copyWith(top: 120),
            sliver: SliverFillRemaining(
              child: BlocBuilder<ChangeEmailBloc, ChangeEmailState>(
                builder: (context, state) {
                  if (state is ChangeEmailSuccess) {
                    context.read<ProfileBloc>().add(ProfileLoadRequested());
                    return _accountEmailUpdatedState(theme, context);
                  }
                  if (state is Loading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is ChangeEmailError) {
                    error = state.error;
                  }
                  return Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            emailCheck,
                            const SizedBox(
                              height: 36,
                            ),
                            Text(
                              "На новую почту будет выслана ссылка для подтверждения",
                              style: theme.textTheme.titleMedium!
                                  .copyWith(color: grey),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 24),
                            TextFieldWidget(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Введите e-mail';
                                } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                    .hasMatch(value)) {
                                  return 'Введите корректный email';
                                }
                                return null;
                              },
                              controller: emailController,
                              labelText: 'E-mail',
                              hintText: 'Введите новую почту',
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 24.0),
                          child: Expanded(
                            child: ButtonWidget(
                                text: "Далее",
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    context
                                        .read<ChangeEmailBloc>()
                                        .add(AccountUpdateEmail(
                                          email: emailController.text.trim(),
                                        ));
                                  }
                                }),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Column _accountEmailUpdatedState(ThemeData theme, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
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
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 24.0),
          child: Expanded(
            child: ButtonWidget(
                text: "Проверить почту",
                onPressed: () => context.router.navigate(ProfileRoute())),
          ),
        )
      ],
    );
  }
}
