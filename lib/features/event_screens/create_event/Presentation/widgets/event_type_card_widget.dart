import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:yourevent/core/data/repositories/models/event_type/event_type_dto.dart';
import 'package:yourevent/router/router.dart';

class EventTypeCardWidget extends StatelessWidget {
  final bool func;
  final double width;
  final double height;
  const EventTypeCardWidget({
    super.key,
    required this.eventType,
    this.func = true,
    required this.height,
    required this.width,
  });
  final EventTypeDto eventType;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => func ? context.router.push(EventDetailsRouteView(eventType: eventType)) : null,
      //TODO: ПРи повороте стэк изменяет размеры
      child: SizedBox(
        width: width,
        height: height,
        child: Stack(
          fit: StackFit.passthrough,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              //TODO: Изменить картикни
              child: Image.network(
                eventType.imageUrl,
                fit: BoxFit.cover,
                width: width,
                height: height,
              ),
            ),
            Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: 12, vertical: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      eventType.name,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: Colors.white, fontSize: 16),
                      overflow: TextOverflow.fade,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
