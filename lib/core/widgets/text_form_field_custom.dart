import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourevent/core/cubits/inputField/input_field_cubit.dart';
import 'package:yourevent/design/colors.dart';

class TextFormFieldCustom extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final bool obscureText;
  final String? Function(String?)? validator; // Функция валидации

  const TextFormFieldCustom({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    this.obscureText = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocProvider(
      create: (context) => InputFieldCubit(),
      child: BlocBuilder<InputFieldCubit, InputFieldState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                labelText,
                style: theme.textTheme.labelMedium,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: controller,
                obscureText: obscureText && !state.isPasswordVisible,
                style: theme.textTheme.labelSmall!.copyWith(fontWeight: FontWeight.w500),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: backgroundInputButton,
                  hintText: hintText,
                  hintStyle: theme.textTheme.labelSmall,
                  suffixIcon: obscureText
                      ? IconButton(
                          icon: Icon(
                            state.isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            context
                                .read<InputFieldCubit>()
                                .togglePasswordVisibility();
                          },
                        )
                      : (controller.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear, color: outlineInputButton),
                              onPressed: () {
                                controller.clear();
                                context.read<InputFieldCubit>().clearText();
                              },
                            )
                          : null),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: controller.text.isNotEmpty
                          ? outlineInputButton
                          : Colors.transparent,
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: outlineInputButton,
                      width: 1.0,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                ),
                validator: validator, // Передаем функцию валидации
                onChanged: (value) {
                  context.read<InputFieldCubit>().textChanged(value);
                },
              ),
            ],
          );
        },
      ),
    );
  }
}