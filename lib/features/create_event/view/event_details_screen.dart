import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourevent/core/widgets/button_widget.dart';
import 'package:yourevent/core/widgets/text_field_widget.dart';
import 'package:yourevent/features/create_event/bloc/bloc.dart';
import 'package:yourevent/features/create_event/widgets/date_time_picker_widget.dart';
import 'package:yourevent/features/create_event/widgets/input_text_details_event_widget.dart';
import 'package:yourevent/router/router.dart';

import '../../../core/ui/ui.dart';
import '../models/event_model.dart';
import '../widgets/event_type_card_widget.dart';

@RoutePage()
class EventDetailsScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final EventTypeModel eventType;
  EventDetailsScreen({super.key, required this.eventType});
  @override
  Widget build(BuildContext context) {
    DateTime? selectedDate;
    TimeOfDay? selectedTime;

    //final theme = Theme.of(context);
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
                      const SizedBox(
                        height: 20,
                      ),
                      InputTextDetailsEventWidget(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Введите название';
                            }
                            return null;
                          },
                          maxLines: 1,
                          height: 1,
                          textController: nameController,
                          label: "Название события",
                          hintText: "Придумайте название"),
                      const SizedBox(
                        height: 24,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DateTimePickerWidget(
                            onDateSelected: (data) => selectedDate = data,
                            isTime: false,
                            label: "Когда?",
                            icon: Icons.calendar_month,
                          ),
                          DateTimePickerWidget(
                            onTimeSelected: (data) => selectedTime = data,
                            isTime: true,
                            label: "Во сколько?",
                            icon: Icons.access_time,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 28,
                      ),
                      InputTextDetailsEventWidget(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Придумайте описание';
                          }
                          return null;
                        },
                        maxLines: null,
                        textController: descriptionController,
                        label: "О событии",
                        hintText: "Придумайте описание",
                        height: 64,
                        maxLength: 100,
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      ButtonWidget(
                          text: 'Далее',
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
                          })
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
