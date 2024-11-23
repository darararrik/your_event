// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:yourevent/core/blocs/blocs.dart';
import 'package:yourevent/core/data/repositories/models/user/user_dto.dart';
import 'package:yourevent/core/utils/utils.dart';
import 'package:yourevent/features/profile_screens/profile/presentation/bloc/profile_bloc.dart';
import 'package:yourevent/features/profile_screens/profile/presentation/widgets/card_options.dart';
import 'package:yourevent/router/router.dart';

@RoutePage()
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    context.read<ProfileBloc>().add(ProfileLoadRequested());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          return _loadingState();
        }
        if (state is ProfileError) {
          return _errorState(state, context);
        }
        if (state is ProfileLoaded) {
          UserDto user = state.user;
          return _profileLoadedState(user, theme, context);
        }
        return const SizedBox();
      },
    );
  }

  Scaffold _profileLoadedState(
      UserDto user, ThemeData theme, BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 40, left: 16, right: 16),
        child: CustomScrollView(
          physics: NeverScrollableScrollPhysics(),
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 70,
                      backgroundImage: NetworkImage(
                          //TODO: Реализация
                          user.urlAvatar),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      user.name,
                      style: theme.textTheme.headlineSmall,
                    ),
                    Text(
                      user.email,
                      style: theme.textTheme.titleSmall,
                    ),
                    //_emailVerfied(user.emailVerified),
                    const SizedBox(
                      height: 40,
                    ),
                    _menu(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Center _errorState(ProfileError state, BuildContext context) {
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

  Center _loadingState() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  ClipRRect _menu(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        color: white,
        child: Column(
          children: [
            CardOptions(
              onTap: () => context.router.navigate(const AccountRoute()),
              leading: const Icon(
                Icons.person_outline_rounded,
                size: 32,
                color: orange,
              ),
              titleText: 'Аккаунт',
            ),
            CardOptions(
              onTap: () => context.router.navigate(const SettingsRoute()),
              leading: const Icon(
                Icons.settings_outlined,
                size: 32,
                color: orange,
              ),
              titleText: 'Настройки',
            ),
            CardOptions(
              onTap: () => context.router.navigate(const AboutRoute()),
              leading: const Icon(
                Icons.info_outline_rounded,
                size: 32,
                color: orange,
              ),
              titleText: 'О приложении',
            ),
          ],
        ),
      ),
    );
  }
}
