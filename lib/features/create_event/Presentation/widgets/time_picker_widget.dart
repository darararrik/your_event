import 'package:flutter/material.dart';

class TimePickerWidget extends StatefulWidget {
  final Function(TimeOfDay)? onTimeSelected;

  const TimePickerWidget({super.key, this.onTimeSelected});

  @override
  State<TimePickerWidget> createState() => _TimePickerWidget();
}

class _TimePickerWidget extends State<TimePickerWidget> {
  String? _selectedTime;

  Future<void> _pickTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(primary: Colors.black),
          ),
          child: MediaQuery(
              data: const MediaQueryData(alwaysUse24HourFormat: true),
              child: child!),
        );
      },
    );

    if (picked != null) {
      setState(() {
        _selectedTime = formatTime(picked);
      });
      // Возвращаем дату через колбэк
      if (widget.onTimeSelected != null) {
        widget.onTimeSelected!(picked);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Время",
          style: theme.textTheme.labelMedium,
        ),
        const SizedBox(height: 8),
        OutlinedButton(
          style: theme.outlinedButtonTheme.style?.copyWith(
              fixedSize: const WidgetStatePropertyAll(Size(184, 48))),
          onPressed: () => _pickTime(context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _selectedTime != null ? _selectedTime! : 'Время',
                style: theme.textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w300,
                  color: Colors.black,
                ),
              ),
              const Icon(
                Icons.access_alarm,
                color: Colors.grey,
                size: 32,
              ),
            ],
          ),
        ),
      ],
    );
  }

  String formatTime(TimeOfDay time) {
    final hours = time.hour.toString().padLeft(2, '0'); // Форматируем часы
    final minutes =
        time.minute.toString().padLeft(2, '0'); // Форматируем минуты
    return '$hours:$minutes'; // Возвращаем строку в формате "HH:MM"
  }
}
