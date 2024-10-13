// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:yourevent/core/utils/utils.dart';

class InputWidget extends StatelessWidget {
  InputWidget({
    super.key,
    required this.labelText,
    this.suffixIcon,
    this.text,
    this.decoration,
    this.onTap,
    this.readOnly,
    this.controller,
    this.validator,
  });
  final String labelText;
  final Icon? suffixIcon;
  final String? text;
  final InputDecoration? decoration;
  final void Function()? onTap;
  final bool? readOnly;
  final TextEditingController? controller;

  String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SizedBox(
        width: double.infinity,
        child: TextFormField(
          validator: validator,
          controller: controller,
          readOnly: readOnly ?? false,
          decoration: InputDecoration(
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                    width: 1,
                    color:
                        outline_Grey), // Цвет полоски при фокусе (не изменяется)
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                    width: 1,
                    color:
                        outline_Grey), // Цвет полоски при фокусе (не изменяется)
              ),
              suffixIcon: suffixIcon,
              label: Text(labelText,
                  style: theme.textTheme.bodySmall!
                      .copyWith(fontSize: 14, color: grey))),
          initialValue: text,
          onTap: onTap,
        ),
      ),
    );
  }
}
