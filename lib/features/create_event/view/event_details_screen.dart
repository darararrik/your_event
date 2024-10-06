import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourevent/features/create_event/bloc/page_view_bloc.dart';
import 'package:yourevent/features/create_event/create_event.dart';
import 'package:yourevent/router/router.dart';

import '../../../core/widgets/widgets.dart';

@RoutePage()
class EventDetailsScreen extends StatelessWidget {
  final EventTypeModel eventType;

  EventDetailsScreen({super.key, required this.eventType});
  final _formKeyFirst = GlobalKey<FormState>();

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
                        context.router.popUntilRoot();
                      }
                    },
                    icon: Icon(Icons.arrow_back),
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
                      Expanded(
                        child: PageView(
                          controller: pageController,
                          physics: const NeverScrollableScrollPhysics(),
                          onPageChanged: (index) {
                            context
                                .read<PageViewBloc>()
                                .add(PageViewChanged(index: index));
                          },
                          children: [
                            EventDetailPage(
                              eventType: eventType,
                              formKey: _formKeyFirst,
                              onDateChanged: (date) {
                                selectedDate = date; // Обновление даты
                              },
                              onTimeChanged: (time) {
                                selectedTime = time; // Обновление времени
                              },
                            ),
                            const Center(child: Text('Second Page')),
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

class EventDetailPage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final GlobalKey<FormState> formKey;
  final Function(DateTime) onDateChanged;
  final Function(TimeOfDay) onTimeChanged;

  final EventTypeModel eventType;
  EventDetailPage(
      {super.key,
      required this.eventType,
      required this.formKey,
      required this.onDateChanged,
      required this.onTimeChanged});

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateEventBloc, CreateEventState>(
      listener: (context, state) {
        if (state is StepOneComplete) {
          context.router.push(CreateEventRoute(eventType: eventType));
        }
      },
      child: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              TextFieldWidget(
                hintText: 'Придумайте название',
                controller: nameController,
                labelText: 'Название события',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Заполните поля!";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              // Поле для выбора даты
              Row(
                // crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DateTimePickerWidget(
                    onDateSelected: (date) {
                      onDateChanged(date);
                    },
                  ),
                  // const SizedBox(width: 12,),
                  TimePickerWidget(
                    onTimeSelected: (time) {
                      onTimeChanged(time);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 24),
              TextFieldWidget(
                hintText: 'Придумайте описание',
                controller: descriptionController,
                labelText: 'О событии',
                maxLength: 120,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Заполните поля!";
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class EventDetailPageTwo extends StatelessWidget {
//   EventDetailPageTwo({super.key, required this.eventType});
//   final EventTypeModel eventType;
//   final TextEditingController costController = TextEditingController();
//   final TextEditingController numberOfPeopleController =
//       TextEditingController();
//   final TextEditingController addressController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: CustomScrollView(
//         slivers: [
//           const SliverAppBar(
//             title: Text("Выберите детали"),
//             centerTitle: true,
//           ),
//           SliverFillRemaining(
//             child: BlocConsumer<CreateEventBloc, CreateEventState>(
//               listener: (context, state) {
//                 if (state is StepTwoComplete) {
//                   context.read<CreateEventBloc>().add(CreateEvent());
//                 }
//               },
//               builder: (context, state) {
//                 if (state is StepOneComplete) {
//                   return Center(
//                     child: Form(
//                       key: formKey,
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 16),
//                         child: Column(
//                           children: [
//                             EventTypeCardWidget(
//                               eventType: eventType,
//                               func: false,
//                               width: 380,
//                               height: 180,
//                             ),
//                             const SizedBox(
//                               height: 20,
//                             ),
//                             TextFieldWidget(
//                                 keyboardType: TextInputType.number,
//                                 validator: (value) {
//                                   if (value == null || value.isEmpty) {
//                                     return 'Поле не может быть пустым!';
//                                   }
//                                   return null;
//                                 },
//                                 maxLines: 1,
//                                 controller: numberOfPeopleController,
//                                 labelText: "Количество людей",
//                                 hintText: "Введите количество"),
//                             const SizedBox(
//                               height: 24,
//                             ),
//                             TextFieldWidget(
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return 'Поле не может быть пустым!';
//                                 }
//                                 return null;
//                               },
//                               maxLines: 1,
//                               labelText: "Какой бюджет?",
//                               hintText: "Введите бюджет",
//                               controller: costController,
//                               keyboardType: TextInputType.number,
//                             ),
//                             const SizedBox(
//                               height: 24,
//                             ),
//                             TextFieldWidget(
//                                 validator: (value) {
//                                   if (value == null || value.isEmpty) {
//                                     return 'Поле не может быть пустым!';
//                                   }
//                                   return null;
//                                 },
//                                 keyboardType: TextInputType.streetAddress,
//                                 maxLines: 1,
//                                 controller: addressController,
//                                 labelText: "Где?",
//                                 hintText: "Напишите адрес"),
//                             const SizedBox(
//                               height: 24,
//                             ),
//                             ButtonWidget(
//                               onPressed: () {
//                                 if (_formKey.currentState!.validate()) {
//                                   context
//                                       .read<CreateEventBloc>()
//                                       .add(StepTwoEnter(
//                                         event: state.event,
//                                         address: addressController.text.trim(),
//                                         numberOfPeople: numberOfPeopleController
//                                             .text
//                                             .trim(),
//                                         cost: costController.text.trim(),
//                                       ));
//                                 }
//                               },
//                               text: 'Далее',
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 } else if (state is Loading) {
//                   return const Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 } else if (state is EventCreated) {
//                   return Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const Text("Круто событие создано"),
//                         ButtonWidget(
//                           onPressed: () {
//                             context.router.replaceAll([const MainRoute()]);
//                           },
//                           text: 'Вернуться на главную',
//                           hasColor: false,
//                         )
//                       ],
//                     ),
//                   );
//                 } else {
//                   return Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const Text(
//                             "Что то не так!\nВернитесь на главную страницу."),
//                         ButtonWidget(
//                           onPressed: () {
//                             context.router.push(const MainRoute());
//                           },
//                           text: 'Вернуться на главную',
//                           hasColor: false,
//                         )
//                       ],
//                     ),
//                   );
//                 }
//               },
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
