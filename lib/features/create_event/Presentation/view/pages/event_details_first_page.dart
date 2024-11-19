import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourevent/core/Data/repositories/models/eventType/event_type_model.dart';
import 'package:yourevent/core/widgets/button_widget.dart';
import 'package:yourevent/core/widgets/text_field_widget.dart';
import 'package:yourevent/features/create_event/Presentation/bloc/create_event/create_event_bloc.dart';
import 'package:yourevent/features/create_event/Presentation/widgets/widgets.dart';

class EventDetailsFirstPage extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController descriptionController;
  final EventTypeModel eventType;
  final GlobalKey<FormState> formKey;
  final VoidCallback onStartDateSelected;
  final VoidCallback onEndDateSelected;
  final DateTime? selectedStartDateTime;
  final DateTime? selectedEndDateTime;

  const EventDetailsFirstPage({
    super.key,
    required this.nameController,
    required this.descriptionController,
    required this.eventType,
    required this.formKey,
    required this.onStartDateSelected,
    required this.onEndDateSelected,
    this.selectedStartDateTime,
    this.selectedEndDateTime,
  });

  String formatDate(DateTime? dateTime) {
    if (dateTime == null) {
      return 'Выберите дату';
    }
    return '${dateTime.day.toString().padLeft(2, '0')}.${dateTime.month.toString().padLeft(2, '0')}.${dateTime.year} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                  label: "Дата начала",
                  onTap: onStartDateSelected,
                  hintText: selectedStartDateTime == null
                      ? 'Выберите дату'
                      : formatDate(selectedStartDateTime),
                ),
                DateTimePickerWidget(
                  hintText: selectedEndDateTime == null
                      ? 'Выберите дату'
                      : formatDate(selectedEndDateTime),
                  label: 'Дата окончания',
                  onTap: onEndDateSelected,
                ),
              ],
            ),
            const SizedBox(height: 24),
            TextFieldWidget(
              maxLines: 1,
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
    );
  }
}
