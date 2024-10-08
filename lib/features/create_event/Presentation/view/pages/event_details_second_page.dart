import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourevent/core/Presentation/widgets/widgets.dart';
import 'package:yourevent/core/utils/images.dart';
import 'package:yourevent/features/create_event/Presentation/Presentation.dart';
import 'package:yourevent/router/router.dart';

class EventDetailsSecondPage extends StatelessWidget {
  const EventDetailsSecondPage({
    super.key,
    required this.formKey,
    required this.priceController,
    required this.numberOfPeopleController,
    required this.addressController,
  });

  final TextEditingController priceController;
  final TextEditingController numberOfPeopleController;
  final TextEditingController addressController;

  final GlobalKey<FormState> formKey;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextFieldWidget(
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Поле не может быть пустым!';
                  }
                  return null;
                },
                maxLines: 1,
                controller: numberOfPeopleController,
                labelText: "Количество людей",
                hintText: "Введите количество"),
            const SizedBox(
              height: 24,
            ),
            TextFieldWidget(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Поле не может быть пустым!';
                }
                return null;
              },
              maxLines: 1,
              labelText: "Какой бюджет?",
              hintText: "Введите бюджет",
              controller: priceController,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(
              height: 24,
            ),
            TextFieldWidget(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Поле не может быть пустым!';
                  }
                  return null;
                },
                keyboardType: TextInputType.streetAddress,
                maxLines: 1,
                controller: addressController,
                labelText: "Где?",
                hintText: "Напишите адрес"),
          ],
        ),
      ),
    );
  }
}
