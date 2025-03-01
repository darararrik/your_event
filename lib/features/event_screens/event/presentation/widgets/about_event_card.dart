import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:yourevent/core/data/repositories/repositories.dart';
import 'package:yourevent/core/utils/utils.dart';

class AboutEventCard extends StatelessWidget {
  final EventDto eventData;

  const AboutEventCard({super.key, required this.eventData});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 4),
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 33,
              spreadRadius: 10,
            )
          ]),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Column(
        children: [
          TextField(
            enabled: false, // Делает поле неактивным
            decoration: InputDecoration(
              labelText: eventData.categoryName,
              labelStyle: theme.textTheme.labelMedium!
                  .copyWith(color: greyLabel, height: 20, fontSize: 18),
            ),
            controller: TextEditingController(
              text: eventData.name,
            ),
            style: theme.textTheme.bodyLarge!.copyWith(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w400), // Черный текст
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextField(
                    enabled: false, // Делает поле неактивным
                    controller: TextEditingController(
                      text: DateFormat('dd.MM.yy HH:mm', 'ru')
                          .format(eventData.startDate),
                    ),
                    decoration: InputDecoration(
                      labelText: "Начало",
                      labelStyle: theme.textTheme.labelMedium!
                          .copyWith(color: greyLabel, fontSize: 18),
                      //border: InputBorder.none, // Убирает полоску
                    ),
                    style: theme.textTheme.bodyLarge!.copyWith(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w400)), // Черный текст
              ),
              Expanded(
                child: TextField(
                    enabled: false, // Делает поле неактивным
                    controller: TextEditingController(
                      text: DateFormat('dd.MM.yy HH:mm', 'ru')
                          .format(eventData.endDate),
                    ),
                    decoration: InputDecoration(
                      labelText: "Конец",
                      labelStyle: theme.textTheme.labelMedium!
                          .copyWith(color: greyLabel, fontSize: 18),
                      //border: InputBorder.none, // Убирает полоску
                    ),
                    style: theme.textTheme.bodyLarge!.copyWith(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w400)), // Черный текст
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              location,
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: TextField(
                  enabled: false, // Делает поле неактивным
                  controller: TextEditingController(
                    text: eventData.address,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none, // Убирает полоску
                  ),
                  style: theme.textTheme.bodyLarge!.copyWith(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w400), // Черный текст
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  people,
                  const SizedBox(
                    width: 8,
                  ),
                  SizedBox(
                    width: 120,
                    child: TextField(
                      enabled: false, // Делает поле неактивным
                      controller: TextEditingController(
                        text: formatPeople(eventData.people),
                      ),
                      decoration: const InputDecoration(
                        border: InputBorder.none, // Убирает полоску
                      ),
                      style: theme.textTheme.bodyLarge!.copyWith(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w400), // Черный текст
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  rubIcon,
                  const SizedBox(
                    width: 8,
                  ),
                  SizedBox(
                    width: 120,
                    child: TextField(
                      enabled: false, // Делает поле неактивным
                      controller: TextEditingController(
                        text: formatNumber(eventData.price),
                      ),
                      decoration: const InputDecoration(
                        border: InputBorder.none, // Убирает полоску
                      ),
                      style: theme.textTheme.bodyLarge!.copyWith(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w400), // Черный текст
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Column(
            children: [
              TextField(
                enabled: false, // Делает поле неактивным
                decoration: InputDecoration(
                  labelText: "О событии",
                  labelStyle: theme.textTheme.labelMedium!
                      .copyWith(color: greyLabel, height: 20, fontSize: 18),
                ),
                controller: TextEditingController(
                  text: eventData.description,
                ),
                style: theme.textTheme.bodyMedium!.copyWith(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w300), // Черный текст
              )
            ],
          ),
        ],
      ),
    );
  }

  String formatNumber(int number) {
    final format = NumberFormat(
        '#,##0', 'ru'); // Форматирование с разделением через пробел
    return format.format(number);
  }

  String formatPeople(int people) {
    if (people % 10 == 1 && people % 100 != 11) {
      return '$people человек';
    } else if (people % 10 >= 2 &&
        people % 10 <= 4 &&
        (people % 100 < 10 || people % 100 >= 20)) {
      return '$people человека';
    } else {
      return '$people человек';
    }
  }
}
