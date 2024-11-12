import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourevent/core/data/repositories/models/event_model.dart';
import 'package:yourevent/core/widgets/widgets.dart';
import 'package:yourevent/features/create_event/presentation/bloc/bloc.dart';
import 'package:yourevent/features/create_event/presentation/widgets/widgets.dart';
import 'package:yourevent/router/router.dart';

class EventDetailsFirstPage extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController descriptionController;
  final GlobalKey<FormState> formKey;
  final Function(DateTime) onDateChanged;
  final Function(TimeOfDay) onTimeChanged;

  final EventTypeModel eventType;
  const EventDetailsFirstPage(
      {super.key,
      required this.eventType,
      required this.formKey,
      required this.onDateChanged,
      required this.onTimeChanged,
      required this.nameController,
      required this.descriptionController});

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateEventBloc, CreateEventState>(
      listener: (context, state) {},
      child: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              TextFieldWidget(
                hintText: 'Придумайте название',
                controller: nameController,
                labelText: 'Название события',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Заполните поля!";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DateTimePickerWidget(
                    onDateSelected: (date) {
                      onDateChanged(date);
                    },
                  ),
                  TimePickerWidget(
                    onTimeSelected: (time) {
                      onTimeChanged(time);
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
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
