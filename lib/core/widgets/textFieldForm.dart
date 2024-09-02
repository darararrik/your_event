import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourevent/core/cubits/inputField/input_field_cubit.dart';
import 'package:yourevent/design/colors.dart';

class TextFieldForm extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final bool obscureText;

  TextFieldForm({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    this.obscureText = false,
  }) : super(key: key);

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
              SizedBox(
                height: 48,
                child: TextField(
                  style: theme.textTheme.labelSmall,
                  controller: controller,
                  obscureText: obscureText ? !state.isPasswordVisible : false,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: backgroundInputButton,
                    hintText: hintText,
                    suffixIcon: obscureText
                        ? IconButton(
                            icon: Icon(
                              state.isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              context.read<InputFieldCubit>().togglePasswordVisibility();
                            },
                          )
                        : (state.hasText
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
                      borderSide: state.hasText
                          ? const BorderSide(
                              color: outlineInputButton, width: 1.0)
                          : BorderSide.none,
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
                  onChanged: (value) {
                    context.read<InputFieldCubit>().textChanged(value);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
