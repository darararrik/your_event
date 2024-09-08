import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourevent/core/blocs/auth/auth_bloc.dart';

import '../../../core/design/design.dart';
import '../../../router/router.dart';

@RoutePage()
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Unauthenticated) {
          context.router.replace(const StartRoute());
        }
      },
      builder: (context, state) {
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
              child: Container(
                child: Row(
                  
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
