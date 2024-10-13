import 'package:flutter/material.dart';
import 'package:yourevent/core/utils/colors.dart';

class Chips extends StatelessWidget {
  final Icon icon;
  final String title;
  const Chips({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: 12, vertical: 4), // Настройка отступов для "кнопки"
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, 5),
            spreadRadius: 0,
            color: Color.fromRGBO(0, 0, 0, 0.06),
            blurRadius: 13,
          )
        ],
        color: white, // Цвет фона "кнопки"
        borderRadius: BorderRadius.circular(8), // Радиус скругления углов
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Все",
            style: theme.textTheme.labelSmall!.copyWith(color: grey),
          ),
          icon,
        ],
      ),
    );
  }
}
