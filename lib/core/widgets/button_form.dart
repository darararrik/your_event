import 'package:flutter/material.dart';
import 'package:yourevent/design/colors.dart';

class ButtonForm extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool hasColor; // Добавлен булевый параметр

  const ButtonForm({
    super.key,
    required this.text,
    required this.onPressed,
    this.hasColor = true, // Значение по умолчанию true
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: hasColor ? orange : white, // Цвет фона
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(
            color: orange, // Цвет границы
            width: 2, // Толщина границы
          ),
        ),
        fixedSize: const Size(380, 53), // Размеры кнопки
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: theme.textTheme.titleMedium?.copyWith(
          color: hasColor ? white :orange )
      ),
    );
  }
}
