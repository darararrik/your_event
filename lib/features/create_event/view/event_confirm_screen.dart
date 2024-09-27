import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:yourevent/features/create_event/models/event_model.dart';
import 'package:yourevent/features/create_event/widgets/event_type_card_widget.dart';
import 'package:yourevent/features/create_event/widgets/input_text_details_event_widget.dart';

@RoutePage()
class CreateEventScreen extends StatelessWidget {
  CreateEventScreen({super.key, required this.eventType});
  final EventTypeModel eventType;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController costController = TextEditingController();
  final TextEditingController numberOfPeopleController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text("Выберите детали"),
            centerTitle: true,
          ),
          SliverFillRemaining(
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
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
                    InputTextDetailsEventWidget(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Поле не может быть пустым!';
                          }
                          return null;
                        },
                        maxLines: 1,
                        height: 1,
                        textController: costController,
                        label: "Какой бюджет",
                        hintText: "Бюджет"),
                    const SizedBox(
                      height: 24,
                    ),
                    InputTextDetailsEventWidget(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Поле не может быть пустым!';
                          }
                          return null;
                        },
                        maxLines: 1,
                        height: 1,
                        textController: numberOfPeopleController,
                        label: "Сколько человек?",
                        hintText: "Количество людей"),
                    InputTextDetailsEventWidget(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Поле не может быть пустым!';
                          }
                          return null;
                        },
                        maxLines: 1,
                        height: 1,
                        textController: addressController,
                        label: "Где",
                        hintText: "Введите адрес!"),
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
