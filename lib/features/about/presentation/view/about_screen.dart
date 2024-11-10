import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:yourevent/core/utils/utils.dart';
import 'package:yourevent/core/widgets/input_widget.dart';
import 'package:yourevent/features/about/presentation/widgets/action_button.dart';

@RoutePage()
class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: CustomScrollView(
        physics: const ScrollPhysics(parent: FixedExtentScrollPhysics()),
        slivers: [
          SliverAppBar(
            centerTitle: true,
            title: Text(
              "О приложении",
              style: theme.textTheme.headlineSmall,
            ),
          ),
          SliverFillRemaining(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _Information(theme: theme),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      ActionButton(
                        onTap: () {},
                        text: "Оценить приложение",
                      ),
                      ActionButton(
                        onTap: () {},
                        text: "Пользовательское соглашение",
                      ),
                      ActionButton(
                        onTap: () {},
                        text: "Лицензионное соглашение",
                      ),
                      ActionButton(
                        onTap: () {},
                        text: "Сообщить о проблеме",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _Information extends StatelessWidget {
  const _Information({
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 24, bottom: 24),
      width: double.infinity,
      color: const Color.fromRGBO(247, 247, 247, 1),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          logo,
          const SizedBox(
            height: 20,
          ),
          Text(
            "Версия 0.00.0",
            style: theme.textTheme.bodyMedium,
          ),
          Text(
            "© 2023-2024 ТвоеСобытие",
            style: theme.textTheme.bodyMedium,
          )
        ],
      ),
    );
  }
}
