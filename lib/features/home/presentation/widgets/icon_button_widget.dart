import 'package:flutter/material.dart';
import 'package:yourevent/core/utils/colors.dart';

class IconButtonWidget extends StatelessWidget {
  final String text;
  final Widget image;
  final VoidCallback onTap;

  const IconButtonWidget({
    super.key,
    required this.text,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 168,
        height: 152,
        decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                offset: Offset(0, 4),
                spreadRadius: 0,
                color: Color.fromRGBO(0, 0, 0, 0.1),
                blurRadius: 33,
              )
            ]),
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
