import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:yourevent/core/blocs/blocs.dart';
import 'package:yourevent/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:yourevent/router/router.dart';



@RoutePage()
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Unauthenticated) {
          // Переход на стартовый экран при выходе пользователя
          context.router.replaceAll([const StartRoute()]);
        }
      },
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ProfileError) {
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
          } else if (state is ProfileLoaded) {
            final user = state.user;

            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  title: const Text("Профиль"),
                  centerTitle: true,
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
                            backgroundImage: NetworkImage(user.photoURL),
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
      ),
    );
  }
}
