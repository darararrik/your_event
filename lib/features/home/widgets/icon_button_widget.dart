import 'package:flutter/material.dart';
import 'package:yourevent/core/design/colors.dart';

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
    return Container(
      width: 170,
      height: 150,
      decoration: BoxDecoration(
        border: Border.all(color: grey,width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(0), // Уменьшение внутреннего отступа
          backgroundColor: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            image,
            const SizedBox(height: 16),
            Text(
              text,
              textAlign: TextAlign.center, // Выравнивание текста по центру
              style: const TextStyle(
                fontSize: 12, // Уменьшение размера текста
                color: grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
