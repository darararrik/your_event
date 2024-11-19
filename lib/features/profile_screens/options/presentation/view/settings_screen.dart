import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourevent/core/blocs/blocs.dart';
import 'package:yourevent/features/profile_screens/options/Presentation/widgets/settings_action_card.dart';
import 'package:yourevent/features/profile_screens/options/Presentation/widgets/settings_toggle_card.dart';

@RoutePage()
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: CustomScrollView(
        //TODO че то сделал
        physics: const ScrollPhysics(parent: FixedExtentScrollPhysics()),
        slivers: [
          SliverAppBar(
            title: Text(
              'Настройки',
              style: theme.textTheme.headlineSmall,
            ),
            centerTitle: true,
          ),
          SliverFillRemaining(
            child: Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16)
                          .copyWith(bottom: 8),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Язык приложения",
                              style: theme.textTheme.titleMedium,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4),
                              child: Row(
                                children: [
                                  Text(
                                    "Русский",
                                    style: theme.textTheme.bodyMedium!
                                        .copyWith(fontWeight: FontWeight.w300),
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: theme.hintColor.withOpacity(0.3),
                                    size: 16,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SettingsToggleCard(
                    title: "Push-уведомления",
                    value: true,
                  ),
                  SettingsActionCard(
                    onTap: () {
                      context.read<AuthBloc>().add(SignOutRequested());
                    },
                    title: "Выйти из аккаунта",
                    textColor: Colors.red,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
