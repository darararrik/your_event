// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:yourevent/core/utils/utils.dart';

import '../../../core/domain/models/event_model.dart';

class EventListCard extends StatelessWidget {
  EventListCard({
    super.key,
    required this.event,
  });
  EventModel event;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(13)),
          gradient: LinearGradient(colors: <Color>[
            Color.fromRGBO(255, 153, 0, 0.49),
            Color.fromRGBO(255, 0, 0, 0.5)
          ])),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.name,
                  style:
                      theme.textTheme.bodyLarge!.copyWith(color: Colors.white),
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
                      "${event.date}, ${event.time}",
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
    );
  }
}
