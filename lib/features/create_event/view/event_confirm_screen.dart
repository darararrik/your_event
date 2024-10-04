import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourevent/features/create_event/widgets/input_text_details_event_widget.dart';
import 'package:yourevent/router/router.dart';

import '../../../core/widgets/widgets.dart';
import '../create_event.dart';

@RoutePage()
class CreateEventScreen extends StatelessWidget {
  CreateEventScreen({super.key, required this.eventType});
  final EventTypeModel eventType;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController costController = TextEditingController();
  final TextEditingController numberOfPeopleController =
      TextEditingController();
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
            child: BlocConsumer<CreateEventBloc, CreateEventState>(
              listener: (context, state) {
                if (state is StepTwoComplete) {
                  context.read<CreateEventBloc>().add(CreateEvent());
                }
              },
              builder: (context, state) {
                if (state is StepOneComplete) {
                  return Center(
                    child: Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
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
                            TextFieldWidget(
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Поле не может быть пустым!';
                                  }
                                  return null;
                                },
                                maxLines: 1,
                                controller: numberOfPeopleController,
                                labelText: "Количество людей",
                                hintText: "Введите количество"),
                            const SizedBox(
                              height: 24,
                            ),
                            TextFieldWidget(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Поле не может быть пустым!';
                                }
                                return null;
                              },
                              maxLines: 1,
                              labelText: "Какой бюджет?",
                              hintText: "Введите бюджет",
                              controller: costController,
                              keyboardType: TextInputType.number,
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            TextFieldWidget(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Поле не может быть пустым!';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.streetAddress,
                                maxLines: 1,
                                controller: addressController,
                                labelText: "Где?",
                                hintText: "Напишите адрес"),
                            const SizedBox(
                              height: 24,
                            ),
                            ButtonWidget(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  context
                                      .read<CreateEventBloc>()
                                      .add(StepTwoEnter(
                                        address: addressController.text.trim(),
                                        numberOfPeople: numberOfPeopleController
                                            .text
                                            .trim(),
                                        cost: costController.text.trim(),
                                      ));
                                }
                              },
                              text: 'Далее',
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                } else if (state is StepTwoComplete) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is EventCreated) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Круто событие создано"),
                        ButtonWidget(
                          onPressed: () {
                            context.router.push(const MainRoute());
                          },
                          text: 'Вернуться на главную',
                          hasColor: false,
                        )
                      ],
                    ),
                  );
                } else {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                            "Что то не так!\nВернитесь на главную страницу."),
                        ButtonWidget(
                          onPressed: () {
                            context.router.push(const MainRoute());
                          },
                          text: 'Вернуться на главную',
                          hasColor: false,
                        )
                      ],
                    ),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
