import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourevent/core/blocs/auth/auth_bloc.dart';

import '../../core/design/design.dart';
@RoutePage()
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
    onPressed: () {
      context.read<AuthBloc>().add(SignOutRequested());
    },
    child: const Text(
      'Logout',
      style: TextStyle(color: black),
    ),
  );
  }
}
