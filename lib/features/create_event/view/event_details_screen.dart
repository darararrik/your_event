import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourevent/features/create_event/create_event.dart';
import 'package:yourevent/router/router.dart';

import '../../../core/widgets/widgets.dart';

@RoutePage()
class EventDetailsScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final EventTypeModel eventType;
  EventDetailsScreen({super.key, required this.eventType});

  DateTime? selectedDate; // Переменная для сохранения даты
  TimeOfDay? selectedTime; // Переменная для сохранения даты

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text("Выберите детали"),
            centerTitle: true,
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            sliver: SliverFillRemaining(
              child: Center(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      EventTypeCardWidget(
                        eventType: eventType,
                        func: false,
                        width: 380,
                        height: 180,
                      ),
                      const SizedBox(height: 20),
                      TextFieldWidget(
                        hintText: 'Придумайте название',
                        controller: nameController,
                        labelText: 'Название события',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Заполните поля!";
                          }
                        },
                      ),
                      const SizedBox(height: 24),
                      // Поле для выбора даты
                      Row(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DateTimePickerWidget(
                            onDateSelected: (date) {
                              selectedDate = date; // Сохранение выбранной даты
                            },
                          ),
                          // const SizedBox(width: 12,),
                          TimePickerWidget(
                            onTimeSelected: (date) {
                              selectedTime = date; // Сохранение выбранной даты
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      TextFieldWidget(
                        hintText: 'Придумайте описание',
                        controller: descriptionController,
                        labelText: 'О событии',
                        maxLength: 120,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Заполните поля!";
                          }
                        },
                      ),
                      const SizedBox(height: 24),
                      ButtonWidget(
                        onPressed: () {
                          if (_formKey.currentState!.validate() &&
                              selectedTime != null &&
                              selectedDate != null) {
                            context.read<CreateEventBloc>().add(StepOneEnter(
                                name: nameController.text.trim(),
                                date: selectedDate!,
                                time: selectedTime!,
                                description:
                                    descriptionController.text.trim()));
                            context.router
                                .push(CreateEventRoute(eventType: eventType));
                          }
                        },
                        text: 'Далее',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
