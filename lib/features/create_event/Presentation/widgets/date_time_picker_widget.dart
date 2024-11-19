import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:yourevent/core/core.dart';

class DateTimePickerWidget extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  final Function(DateTime)? onDateSelected;

  final String hintText;

  const DateTimePickerWidget({
    super.key,
    required this.label,
    required this.hintText,
    required this.onTap,
    this.onDateSelected,
  });

  @override
  State<DateTimePickerWidget> createState() => _DateTimePickerWidgetState();
}

class _DateTimePickerWidgetState extends State<DateTimePickerWidget> {
  DateTime? _selectedDate;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: widget.onTap, // При нажатии вызывается переданный метод
          child: Container(
            width: 184,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: backgroundInputButton,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.transparent),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.hintText,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w300,
                      ),
                ),
                const Icon(Icons.calendar_today),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
