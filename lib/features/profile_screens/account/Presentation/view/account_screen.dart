import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourevent/core/blocs/blocs.dart';
import 'package:yourevent/core/utils/utils.dart';
import 'package:yourevent/core/widgets/widgets.dart';
import 'package:yourevent/core/widgets/input_widget.dart';
import 'package:yourevent/features/features.dart';
import 'package:yourevent/features/profile_screens/account/presentation/bloc/change_name_bloc.dart';
import 'package:yourevent/router/router.dart';

@RoutePage()
class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(ProfileLoadRequested());
  }

  @override
  void dispose() {
    nameController.dispose();
    surnameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: CustomScrollView(
        physics: const NeverScrollableScrollPhysics(),
        slivers: [
          SliverAppBar(
            title: Text(
              "Аккаунт",
              style: theme.textTheme.headlineSmall,
            ),
            centerTitle: true,
          ),
          SliverFillRemaining(
            child: Padding(
              padding: const EdgeInsets.only(top: 16),
              child: BlocListener<ChangeNameBloc, ChangeNameState>(
                listener: (context, state) {
                  if (state is ChangeNameSuccess) {
                    context.read<ProfileBloc>().add(ProfileLoadRequested());
                    const snackBar = SnackBar(
                      behavior: SnackBarBehavior.floating,
                      content: Text('Ваши данные успешно сохранены'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                child: BlocBuilder<ProfileBloc, ProfileState>(
                  builder: (context, state) {
                    if (state is ProfileLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state is ProfileLoaded) {
                      final user = state.user;
                      nameController.text = user.name;
                      surnameController.text = user.surname;

                      return Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius: 70,
                              backgroundImage: NetworkImage(user.urlAvatar),
                              //TODO: Реализация
                              onBackgroundImageError: (_, __) {
                                debugPrint('Ошибка загрузки аватарки');
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: Text(
                                "Изменить фото",
                                style: theme.textTheme.titleLarge!
                                    .copyWith(color: orange),
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            InputWidget(
                              controller: nameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Введите новое имя';
                                }
                                return null;
                              },
                              labelText: 'Имя',
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            InputWidget(
                              controller: surnameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Введите новую фамилию';
                                }
                                return null;
                              },
                              labelText: 'Фамилия',
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            InputWidget(
                                readOnly: true,
                                text: user.email,
                                onTap: () =>
                                    context.router.navigate(ChangeEmailRoute()),
                                labelText: 'E-mail',
                                suffixIcon: const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 16,
                                  color: grey,
                                )),
                            const SizedBox(
                              height: 16,
                            ),
                            InputWidget(
                                suffixIcon: const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 16,
                                  color: grey,
                                ),
                                readOnly: true,
                                text: "Сменить пароль",
                                onTap: () => context.router
                                    .navigate(const ChangePasswordRoute()),
                                labelText: 'Пароль'),
                            const SizedBox(
                              height: 40,
                            ),
                            //TODO: Реализовать кнопку серой
                            SizedBox(
                              width: 384,
                              child: ButtonWidget(
                                  text: "Сохранить изменения",
                                  onPressed: () {
                                    if (_formKey.currentState!.validate() &&
                                            user.name !=
                                                nameController.text.trim() ||
                                        user.surname !=
                                            surnameController.text.trim()) {
                                      context
                                          .read<ChangeNameBloc>()
                                          .add(AccountUpdateName(
                                            name: nameController.text.trim(),
                                            surname:
                                                surnameController.text.trim(),
                                          ));
                                    }
                                  }),
                            )
                          ],
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
