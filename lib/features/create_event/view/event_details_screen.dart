import 'dart:ffi';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:yourevent/core/widgets/text_form_field_widget.dart';
import 'package:yourevent/features/create_event/widgets/event_type_card_widget.dart';

import '../models/models.dart';

@RoutePage()
class EventDetailsScreen extends StatelessWidget {
  final TextEditingController nameEventController = TextEditingController(); 
  final EventTypeModel eventType;
  EventDetailsScreen({super.key, required this.eventType});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text("Выберите детали"),
            centerTitle: true,
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 16),

            sliver: SliverFillRemaining(
              child: Center(
                child: Column(
                  children: [
                    EventTypeCardWidget(eventType: eventType, func: false, width: 380, height: 180,),
                    const SizedBox(height: 20,),
                    TextFormFieldWidget(controller: nameEventController, labelText: "Название события", hintText: "Придумайте название"),
                    Row(children: [
                      
                    ],)
              
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
