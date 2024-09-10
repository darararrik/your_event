import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:yourevent/core/blocs/auth/auth_bloc.dart';
import 'package:yourevent/features/profile/bloc/profile_bloc.dart';

import '../../../core/models/user_model.dart';
import '../../../router/router.dart';

@RoutePage()
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileInitial) {
          context.read<ProfileBloc>().add(ProfileLoadRequested());
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is ProfileError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  state.error.toString(), // Вывод сообщения об ошибке
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                ElevatedButton(
                  onPressed: () {
                    context.read<ProfileBloc>().add(ProfileLoadRequested());
                  },
                  child: const Text('Повторить попытку'),
                ),
              ],
            ),
          );
        }
        if (state is ProfileLoaded) {
          final user = state.user;

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                toolbarHeight: 108,
                actions: [
                  IconButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(SignOutRequested());
                    },
                    icon: const Icon(
                      Icons.exit_to_app_rounded,
                      size: 32,
                      color: Colors.redAccent,
                    ),
                  ),
                ],
              ),
              SliverFillRemaining(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Center(
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: user.photoURL.isNotEmpty
                              ? NetworkImage(user.photoURL)
                              : const AssetImage(
                                      'assets/images/default_avatar.png')
                                  as ImageProvider,
                          onBackgroundImageError: (_, __) {
                            debugPrint('Ошибка загрузки аватарки');
                          },
                        ),
                        const SizedBox(height: 16),
                        Text(
                          user.displayName,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        } else {
          return const Center(child: Text('Не удалось загрузить профиль.'));
        }
      },
    );
  }
}
