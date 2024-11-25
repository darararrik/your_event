import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourevent/core/data/repositories/models/models.dart';
import 'package:yourevent/core/utils/images.dart';
import 'package:yourevent/core/widgets/widgets.dart';
import 'package:yourevent/features/event_screens/create_event/create_event.dart';

import 'package:yourevent/router/router.dart';

@RoutePage()
class EventDetailsPageView extends StatefulWidget {
  final EventTypeDto eventType;

  const EventDetailsPageView({
    super.key,
    required this.eventType,
  });

  @override
  State<EventDetailsPageView> createState() => _EventDetailsPageViewState();
}

class _EventDetailsPageViewState extends State<EventDetailsPageView> {
  DateTime? selectedStartDateTime; // Полный объект для начала события
  DateTime? selectedEndDateTime; // Полный объект для конца события

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController numberOfPeopleController =
      TextEditingController();
  final TextEditingController addressController = TextEditingController();

  final _formKeyFirst = GlobalKey<FormState>();
  final _formKeySecond = GlobalKey<FormState>();

  /// Метод для выбора даты и времени
  Future<void> _selectDateTime({
    required BuildContext context,
    required bool isStart,
  }) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: isStart
          ? (selectedStartDateTime ?? DateTime.now())
          : (selectedEndDateTime ?? DateTime.now()),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        initialTime: TimeOfDay.fromDateTime(isStart
            ? (selectedStartDateTime ?? DateTime.now())
            : (selectedEndDateTime ?? DateTime.now())),
        context: context,
      );

      if (pickedTime != null) {
        setState(() {
          final newDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
          if (isStart) {
            selectedStartDateTime = newDateTime;
          } else {
            selectedEndDateTime = newDateTime;
          }
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<CreateEventBloc>().add(ResetEvent());
  }

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
                if (state is CreateEventErrorState) {
                  final error = state.error.toString();
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(error),
                        const SizedBox(height: 16),
                        ButtonWidget(
                          text: "Вернуться на главную",
                          onPressed: () =>
                              context.router.replaceAll([const MainRoute()]),
                        ),
                      ],
                    ),
                  );
                }

                if (state is CreateEventLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is CreateEventSuccess) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16)
                        .copyWith(top: 200),
                    child: Column(
                      children: [
                        successPicture,
                        const SizedBox(height: 36),
                        Text(
                          "Событие успешно создано!",
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          "Изменить событие и посмотреть его подробности можно в событиях",
                          style: Theme.of(context).textTheme.titleMedium,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 80),
                        ButtonWidget(
                          text: "Мои события",
                          onPressed: () =>
                              context.router.navigate(const MyEventsRoute()),
                        ),
                        const SizedBox(height: 12),
                        ButtonWidget(
                          text: "Вернуться на главную",
                          hasColor: false,
                          onPressed: () =>
                              context.router.replaceAll([const MainRoute()]),
                        ),
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
                            eventType: widget.eventType,
                            func: false,
                            width: 380,
                            height: 180,
                          ),
                          SizedBox(
                            height: 460,
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
                                  selectedEndDateTime: selectedEndDateTime,
                                  selectedStartDateTime: selectedStartDateTime,
                                  nameController: nameController,
                                  descriptionController: descriptionController,
                                  eventType: widget.eventType,
                                  formKey: _formKeyFirst,
                                  onStartDateSelected: () => _selectDateTime(
                                      context: context, isStart: true),
                                  onEndDateSelected: () => _selectDateTime(
                                      context: context, isStart: false),
                                ),
                                EventDetailsSecondPage(
                                  formKey: _formKeySecond,
                                  addressController: addressController,
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
                                  selectedStartDateTime != null &&
                                  selectedEndDateTime != null) {
                                pageController.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              }
                              if (pageIndex == 1 &&
                                  _formKeySecond.currentState!.validate()) {
                                context.read<CreateEventBloc>().add(
                                      SubmitEvent(
                                        name: nameController.text.trim(),
                                        people: int.parse(
                                            numberOfPeopleController.text
                                                .trim()),
                                        price: int.parse(
                                            priceController.text.trim()),
                                        startDate: selectedStartDateTime!,
                                        endDate: selectedEndDateTime!,
                                        address: addressController.text.trim(),
                                        categoryId: widget.eventType.id,
                                        description:
                                            descriptionController.text.trim(),
                                      ),
                                    );
                              }
                            },
                            text: 'Далее',
                          ),
                        ],
                      ),
                    ),
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
