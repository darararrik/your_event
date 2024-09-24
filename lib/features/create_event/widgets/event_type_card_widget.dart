import 'package:flutter/material.dart';
import 'package:yourevent/features/create_event/models/event_model.dart';

class EventTypeCardWidget extends StatelessWidget {
  const EventTypeCardWidget({
    super.key,
    required this.eventType,
  });

  final EventTypeModel eventType;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 180,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              eventType.imageUrl,
              fit: BoxFit.cover,
              width: 200,
              height: 180,
            ),
          ),
          Container(
            width: 200,
            height: 180,
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
    );
  }
}
