import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimePickerWidget extends StatefulWidget {
  final Function(DateTime)? onDateSelected;

  const DateTimePickerWidget({super.key, this.onDateSelected});

  @override
  State<DateTimePickerWidget> createState() => _DateTimePickerWidgetState();
}

class _DateTimePickerWidgetState extends State<DateTimePickerWidget> {
  DateTime? _selectedDate;

  final DateTime now = DateTime.now();

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year, now.month, now.day),
      lastDate: DateTime(2026),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(primary: Colors.black),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
      // Возвращаем дату через колбэк
      if (widget.onDateSelected != null) {
        widget.onDateSelected!(picked);
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
          "Дата",
          style: theme.textTheme.labelMedium,
        ),
        const SizedBox(height: 8),
        OutlinedButton(
          style: theme.outlinedButtonTheme.style?.copyWith(
              fixedSize: const WidgetStatePropertyAll(Size(184, 48))),
          onPressed: () => _pickDate(context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _selectedDate != null
                    ? DateFormat('dd-MM-yyyy').format(_selectedDate!)
                    : 'Дата',
                style: theme.textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w300,
                  color: Colors.black,
                ),
              ),
              const Icon(
                Icons.calendar_month,
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
