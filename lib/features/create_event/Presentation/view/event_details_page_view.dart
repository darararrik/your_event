// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourevent/core/utils/images.dart';

import 'package:yourevent/router/router.dart';

import '../../../../core/widgets/widgets.dart';
import '../../../features.dart';

@RoutePage()
class EventDeatailsPageView extends StatelessWidget {
  final EventTypeModel eventType;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController numberOfPeopleController =
      TextEditingController();
  final TextEditingController adrressController = TextEditingController();
  EventDeatailsPageView({
    super.key,
    required this.eventType,
  });
  final _formKeyFirst = GlobalKey<FormState>();
  final _formKeySecond = GlobalKey<FormState>();

  DateTime? selectedDate; // Переменная для сохранения даты
  String? selectedTime;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PageViewBloc(),
      child: BlocBuilder<PageViewBloc, PageViewState>(
        builder: (context, state) {
          final pageIndex = (state is PageViewUpdated) ? state.pageIndex : 0;
          final pageController = PageController(initialPage: pageIndex);

          return Scaffold(
            body: BlocBuilder<CreateEventBloc, CreateEventState>(
              builder: (context, state) {
                if (state is EventCreated) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        placeholder,
                        const SizedBox(
                          height: 24,
                        ),
                        Text(
                          "Событие успешно создано!",
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Text(
                          "Изменить событие и посмотреть его подробности можно в событиях",
                          style: Theme.of(context).textTheme.titleMedium,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        ButtonWidget(
                          text: "Мои события",
                          onPressed: () =>
                              context.router.navigate(const MyEventsRoute()),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        ButtonWidget(
                            text: "Вернуться на главную",
                            hasColor: false,
                            onPressed: () =>
                                context.router.replaceAll([const MainRoute()])),
                      ],
                    ),
                  );
                }
                return CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      title: const Text("Введите детали"),
                      centerTitle: true,
                      leading: IconButton(
                        onPressed: () {
                          if (pageIndex > 0) {
                            pageController.previousPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          } else {
                            context.router.navigate(const EventTypeRoute());
                          }
                        },
                        icon: const Icon(Icons.arrow_back),
                      ),
                    ),
                    SliverFillRemaining(
                      child: Column(
                        children: [
                          EventTypeCardWidget(
                            eventType: eventType,
                            func: false,
                            width: 380,
                            height: 180,
                          ),
                          SizedBox(
                            height: 400,
                            child: PageView(
                              controller: pageController,
                              physics: const NeverScrollableScrollPhysics(),
                              onPageChanged: (index) {
                                context
                                    .read<PageViewBloc>()
                                    .add(PageViewChanged(index: index));
                              },
                              children: [
                                EventDetailsFirstPage(
                                  nameController: nameController,
                                  descriptionController: descriptionController,
                                  eventType: eventType,
                                  formKey: _formKeyFirst,
                                  onDateChanged: (date) {
                                    selectedDate = date; // Обновление даты
                                  },
                                  onTimeChanged: (time) {
                                    selectedTime = time; // Обновление времени
                                  },
                                ),
                                EventDetailsSecondPage(
                                  formKey: _formKeySecond,
                                  addressController: adrressController,
                                  priceController: priceController,
                                  numberOfPeopleController:
                                      numberOfPeopleController,
                                ),
                              ],
                            ),
                          ),
                          ButtonWidget(
                            onPressed: () {
                              if (pageIndex < 1 &&
                                  _formKeyFirst.currentState!.validate() &&
                                  selectedTime != null &&
                                  selectedDate != null) {
                                pageController.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              }
                              if (pageIndex == 1 &&
                                  _formKeySecond.currentState!.validate()) {
                                context.read<CreateEventBloc>().add(CreateEvent(
                                    date: selectedDate!,
                                    name: nameController.text.toString().trim(),
                                    description: descriptionController.text
                                        .toString()
                                        .trim(),
                                    time: selectedTime!,
                                    numberOfPeople: numberOfPeopleController
                                        .text
                                        .toString()
                                        .trim(),
                                    address: adrressController.text
                                        .toString()
                                        .trim(),
                                    price: priceController.text
                                        .toString()
                                        .trim()));
                              }
                            },
                            text: 'Далее',
                          ),
                        ],
                      ),
                    )
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
