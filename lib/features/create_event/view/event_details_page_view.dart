import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourevent/features/create_event/create_event.dart';
import 'package:yourevent/features/create_event/view/pages/event_details_first_page.dart';
import 'package:yourevent/features/create_event/view/pages/event_details_second_page.dart';
import 'package:yourevent/router/router.dart';

import '../../../core/widgets/widgets.dart';

@RoutePage()
class EventDeatailsPageView extends StatelessWidget {
  final EventTypeModel eventType;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController numberOfPeopleController =
      TextEditingController();
  final TextEditingController adrressController = TextEditingController();
  EventDeatailsPageView({super.key, required this.eventType});
  final _formKeyFirst = GlobalKey<FormState>();
  final _formKeySecond = GlobalKey<FormState>();

  DateTime? selectedDate; // Переменная для сохранения даты
  TimeOfDay? selectedTime;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PageViewBloc(),
      child: BlocBuilder<PageViewBloc, PageViewState>(
        builder: (context, state) {
          final pageIndex = (state is PageViewUpdated) ? state.pageIndex : 0;
          final pageController = PageController(initialPage: pageIndex);

          return Scaffold(
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  title: const Text("data"),
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
                                duration: const Duration(microseconds: 300),
                                curve: Curves.bounceIn);
                          }
                          if (pageIndex == 1 &&
                              _formKeySecond.currentState!.validate()) {
                            context.read<CreateEventBloc>().add(CreateEvent(
                                date: selectedDate!,
                                name: nameController.toString().trim(),
                                description:
                                    descriptionController.toString().trim(),
                                time: selectedTime!,
                                numberOfPeople:
                                    numberOfPeopleController.toString().trim(),
                                address: adrressController.toString().trim(),
                                price: priceController.toString().trim()));
                          }
                        },
                        text: 'Далее',
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
