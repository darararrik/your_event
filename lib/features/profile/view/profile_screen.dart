import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourevent/core/blocs/auth/auth_bloc.dart';
import 'package:yourevent/features/profile/bloc/profile_bloc.dart';

import '../../../core/design/design.dart';
import '../../../core/models/user_model.dart';
import '../../../router/router.dart';

@RoutePage()
class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? user;

  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(ProfileLoadRequested());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (BuildContext context, ProfileState state) {
        if (state is ProfileError) {
          context.router.replaceNamed("/start");
        } else if (state is ProfileLoaded) {
          user = state.user;
        }
      },
      builder: (context, state) {
        if (state is ProfileLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
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
              child: Column(
                children: [
                  Center(
                      child: CircleAvatar(
                    backgroundImage: NetworkImage(user!.photoURL),
                    child: Text(user!.displayName),
                  ))
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
