import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourevent/core/blocs/auth/auth.dart';
import 'package:yourevent/features/home/widgets/icon_button_widget.dart';
import 'package:yourevent/router/router.dart';

import '../../core/design/design.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Unauthenticated) {
            context.router.replace(const StartRoute());
          }
        },
        builder: (context, state) {
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                title: logo,
                centerTitle: true,
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: IconButton(
                      icon: Icon(
                        Icons.notifications_outlined,
                        size: 32,
                        color: theme.primaryColor,
                      ),
                      onPressed: () {},
                    ),
                  )
                ],
              ),
              SliverFillRemaining(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Хотите организовать мероприятие?",
                    style: theme.textTheme.bodyLarge!.copyWith(height: 1),
                  ),
                  Text(
                    "Выберите способ организации",
                    style: theme.textTheme.bodySmall!.copyWith(color: grey),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButtonWidget(
                        text: 'Выбрать агентство мероприятий',
                        image: faqSearch,
                        onPressed: () {},
                      ),
                      const SizedBox(width: 60),
                      IconButtonWidget(
                        text: 'Нет, спасибо, организую сам',
                        image: package,
                        onPressed: () {},
                      ),
                    ],
                  )
                ],
              ))
            ],
          );
        },
      ),
    );
  }
}

            // return ElevatedButton(
            //     onPressed: () {
            //       context.read<AuthBloc>().add(SignOutRequested());
            //     },
            //     child: const Text(
            //       'Logout',
            //       style: TextStyle(color: black),
            //     ),
            //   );