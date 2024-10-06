import 'package:flutter/material.dart';
import 'package:yourevent/core/utils/ui.dart';

class InputTextDetailsEventWidget extends StatelessWidget {
  final TextEditingController textController;
  final String label;
  final String hintText;
  final double height;
  final int? maxLines;
  final int? maxLength;
  final String? Function(String?) validator;

  const InputTextDetailsEventWidget({
    super.key,
    required this.textController,
    required this.label,
    required this.hintText,
    required this.height,
    this.maxLines,
    this.maxLength = 48,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.labelMedium,
        ),
        const SizedBox(
          height: 8,
        ),
        TextFormField(
          validator: validator,
          controller: textController,
          style: theme.textTheme.bodyMedium,
          maxLines: maxLines, // Позволяет текстовому полю расширяться
          //TODO: ХЗ СКОК СИМВОЛОВ
          maxLength: maxLength,

          decoration: InputDecoration(
            fillColor: backgroundInputButton,
            counterText: "",
            hintText: hintText,

            contentPadding: const EdgeInsets.symmetric(
                vertical: 24, horizontal: 12), // Вертикальные отступы
            hintStyle: theme.textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.w300,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
