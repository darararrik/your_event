import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourevent/core/blocs/event_type/event_type_bloc.dart';
import 'package:yourevent/core/data/repositories/models/event_type/event_type_dto.dart';
import 'package:yourevent/features/event_screens/create_event/presentation/widgets/event_type_card_widget.dart';

@RoutePage()
class EventTypeScreen extends StatefulWidget {
  const EventTypeScreen({super.key});

  @override
  State<EventTypeScreen> createState() => _EventTypeScreenState();
}

class _EventTypeScreenState extends State<EventTypeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<EventTypeBloc>().add(const LoadEvent(completer: null));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          final completer = Completer();
          context.read<EventTypeBloc>().add(LoadEvent(completer: completer));
          return completer.future;
        },
        child: CustomScrollView(
          slivers: [
            const SliverAppBar(
              title: Text("Выберите тип события"),
              centerTitle: true,
            ),
            BlocBuilder<EventTypeBloc, EventTypeState>(
              builder: (context, state) {
                if (state is EventTypesLoaded) {
                  List<EventTypeDto> list = state.list;
                  // Получаем список типов событий

                  return SliverPadding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0), // Отступы только для карточек
                    sliver: SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Количество столбцов
                        crossAxisSpacing: 12, // Промежуток между столбцами
                        mainAxisSpacing: 24, // Промежуток между строками
                        childAspectRatio:
                            1, // Соотношение ширины и высоты карточки
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          final eventType = list[index];
                          return EventTypeCardWidget(
                            func: true,
                            eventType: eventType,
                            height: 180,
                            width: 200,
                          );
                        },
                        childCount: list.length, // Количество карточек
                      ),
                    ),
                  );
                } else {
                  return const SliverFillRemaining(child: SizedBox());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
