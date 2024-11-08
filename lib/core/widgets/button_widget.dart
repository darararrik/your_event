import 'package:flutter/material.dart';
import 'package:yourevent/core/utils/utils.dart';


class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool hasColor; // Добавлен булевый параметр

  const ButtonWidget({
    super.key,
    required this.text,
    required this.onPressed,
    this.hasColor = true, // Значение по умолчанию true
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextButton(
      
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(hasColor ? orange : white),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(
              color: orange,
              width: 2,
            ),
          ),
        ),
        fixedSize: WidgetStateProperty.all<Size>(const Size(380, 52)),
      ),
      child: Text(text,
          style: theme.textTheme.labelLarge!.copyWith(fontSize: 18, color: hasColor ? white : orange)),
    );
  }
}
