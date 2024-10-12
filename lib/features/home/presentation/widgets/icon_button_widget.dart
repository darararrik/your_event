import 'package:flutter/material.dart';
import 'package:yourevent/core/utils/colors.dart';

class IconButtonWidget extends StatelessWidget {
  final String text;
  final Widget image;
  final VoidCallback onPressed;

  const IconButtonWidget({
    super.key,
    required this.text,
    required this.image,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: 160,
      height: 160,
      decoration: BoxDecoration(
        border: Border.all(color: theme.primaryColor, width: 2),
        borderRadius: BorderRadius.circular(24),
      ),
      child: TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(Colors.white),
          overlayColor: WidgetStateProperty.all(Colors.transparent),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            image,
            const SizedBox(height: 16),
            Text(
              text,
              textAlign: TextAlign.center, // Выравнивание текста по центру
              style: theme.textTheme.labelSmall!.copyWith(color: grey),
            ),
          ],
        ),
      ),
    );
  }
}
