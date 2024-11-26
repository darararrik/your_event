import 'package:flutter/material.dart';
import 'package:yourevent/core/utils/utils.dart';
import 'package:yourevent/features/home/Presentation/view/home_screen.dart';
import 'package:yourevent/features/home/Presentation/widgets/sort_filter_icon_widget.dart';

class FilterWidget extends StatelessWidget {
  final int number;

  const FilterWidget({super.key, required this.number});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 8, 0, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Выберите услуги",
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Найдено $number объявлений",
                    style: theme.textTheme.bodySmall,
                  )
                ],
              ),
              Row(
                children: [
                  SortFilterIconWidget(
                    icon: sortIcon,
                    onTap: () {
                      showSortOptions(context);
                    },
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  SortFilterIconWidget(icon: filterIcon, onTap: () {}),
                ],
              ),
            ],
          ),
        ),
      ),
      const SizedBox(
        height: 20,
      ),
    ]);
  }
}
