import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:yourevent/features/create_event/view/event_details_screen.dart';

import '../../../core/ui/ui.dart';

class DateTimePickerWidget extends StatefulWidget {
  final bool isTime; // Если true — выбор времени, если false — выбор даты
  final String label;
  final IconData icon;
  final void Function(DateTime date)? onDateSelected;
  final void Function(TimeOfDay time)? onTimeSelected;

  const DateTimePickerWidget({
    super.key,
    required this.isTime,
    required this.label,
    required this.icon,
    this.onDateSelected,
    this.onTimeSelected,
  });

  @override
  // ignore: library_private_types_in_public_api
  _DateTimePickerWidgetState createState() => _DateTimePickerWidgetState();
}

class _DateTimePickerWidgetState extends State<DateTimePickerWidget> {
  final DateTime now = DateTime.now();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  Future<void> _pickDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year, now.month, now.day),
      lastDate: DateTime(2026),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(primary: black),
          ),
          child: child!,
        );
      },
    );
    if (pickedDate != null) {
      setState(() {
        widget.onDateSelected!(pickedDate);
      });
    }
  }

  Future<void> _pickTime(BuildContext context) async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            timePickerTheme: const TimePickerThemeData(),
            //TODO: Дизайнер должен поменять цвет
            colorScheme: const ColorScheme.light(primary: black),
          ),
          child: MediaQuery(
              data: const MediaQueryData(alwaysUse24HourFormat: true),
              child: child!),
        );
      },
    );
    if (pickedTime != null) {
      setState(() {
        pickedTime.format(context);
        widget.onTimeSelected!(pickedTime);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: theme.textTheme.labelMedium,
        ),
        const SizedBox(height: 8),
        OutlinedButton(
          style: theme.outlinedButtonTheme.style,
          onPressed: () {
            if (widget.isTime) {
              _pickTime(context);
            } else {
              _pickDate(context);
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Text(
              //   widget.isTime
              //       ? (widget.onTimeSelected != null
              //           ? "${selectedTime!.hour}}:${selectedTime!.minute}"
              //           : "Время")
              //       : (widget.onDateSelected != null
              //           ? DateFormat('dd-MM-yyyy')
              //               .format(selectedDate!)
              //           : "Дата"),
              //   style: theme.textTheme.bodyMedium!.copyWith(
              //     fontWeight: FontWeight.w300,
              //     color: black,
              //   ),
              // ),
              Icon(
                widget.icon,
                color: Colors.grey,
                size: 32,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
