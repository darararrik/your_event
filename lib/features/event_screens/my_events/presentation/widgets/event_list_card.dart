// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:yourevent/core/internal/your_event_app.dart';
import 'package:yourevent/lib.dart';

class EventListCard extends StatelessWidget {
  const EventListCard({
    super.key,
    required this.event,
  });
  final EventDto event;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final String formattedDate =
        DateFormat('dd.MM.yyyy HH:mm').format(event.endDate);
    return GestureDetector(
      onTap: () => context.router.push(EventRoute(eventData: event)),
      child: Container(
        margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(13)),
          gradient: LinearGradient(
            colors: <Color>[
              Color.fromRGBO(255, 153, 0, 1),
              Color.fromRGBO(255, 0, 0, 1)
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.name,
                    style: theme.textTheme.bodyLarge!
                        .copyWith(color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time_rounded,
                        color: white,
                        size: 16,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        formattedDate,
                        style: theme.textTheme.bodyMedium!
                            .copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: white,
                    size: 32,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
