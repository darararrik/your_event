import 'package:flutter/material.dart';

class RowIcon extends StatelessWidget {
  final onTapFunc;
  final Icon icon;
  final String title;
  const RowIcon(
      {super.key, required this.onTapFunc, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTapFunc,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: theme.textTheme.headlineMedium,
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.fromLTRB(
                12, 2, 4, 2), // Настройка отступов для "кнопки"
            decoration: BoxDecoration(
              color: const Color.fromARGB(
                  100, 201, 195, 195), // Цвет фона "кнопки"
              borderRadius:
                  BorderRadius.circular(16), // Радиус скругления углов
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Все",
                  style: theme.textTheme.labelSmall,
                ),
                icon,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
