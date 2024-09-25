import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:yourevent/core/widgets/text_field_widget.dart';
import 'package:yourevent/features/create_event/widgets/date_time_picker_widget.dart';

import '../../../core/ui/ui.dart';
import '../models/event_model.dart';
import '../widgets/event_type_card_widget.dart';

@RoutePage()
class EventDetailsScreen extends StatelessWidget {
  final TextEditingController nameEventController = TextEditingController();
  final EventTypeModel eventType;
  EventDetailsScreen({super.key, required this.eventType});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text("Выберите детали"),
            centerTitle: true,
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            sliver: SliverFillRemaining(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    EventTypeCardWidget(
                      eventType: eventType,
                      func: false,
                      width: 380,
                      height: 180,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text("Название события", style: theme.textTheme.labelMedium,),
                    const SizedBox(height: 8,),
                    Container(
                      height: 64,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: backgroundInputButton,
                      ),
                      child: TextFormField(
                        controller: nameEventController,
                        style: theme.textTheme.bodyMedium,
                        decoration: InputDecoration(
                          hintText: "Придумайте название",

                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 24,
                              horizontal: 12), // Вертикальные отступы
                          hintStyle:
                              theme.textTheme.bodyMedium!.copyWith(
                                    fontWeight: FontWeight.w300,
                                  ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DateTimePickerWidget(
                          isTime: false,
                          label: "Когда?",
                          icon: Icons.calendar_month,
                        ),
                        DateTimePickerWidget(
                          isTime: true,
                          label: "Во сколько?",
                          icon: Icons.access_time,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
