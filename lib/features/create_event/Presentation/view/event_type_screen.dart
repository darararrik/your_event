import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourevent/core/utils/images.dart';
import 'package:yourevent/features/create_event/Presentation/bloc/page_view/page_view_bloc.dart';
import 'package:yourevent/features/create_event/models/event_model.dart';
import 'package:yourevent/features/create_event/Presentation/widgets/event_type_card_widget.dart';
import 'package:yourevent/router/router.dart';
import '../../../home/models/models.dart';
import '../../../../core/Presentation/blocs/create_event/create_event_bloc.dart';

@RoutePage()
class EventTypeScreen extends StatefulWidget {
  const EventTypeScreen({super.key});

  @override
  State<EventTypeScreen> createState() => _EventTypeScreenState();
}

class _EventTypeScreenState extends State<EventTypeScreen> {
  @override
  void initState() {
    final completer = Completer();
    context.read<CreateEventBloc>().add(EventTypesLoad(completer: completer));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          final completer = Completer();
          context
              .read<CreateEventBloc>()
              .add(EventTypesLoad(completer: completer));
          return completer.future;
        },
        child: CustomScrollView(
          slivers: [
            const SliverAppBar(
              title: Text("Выберите тип события"),
              centerTitle: true,
            ),
            BlocBuilder<CreateEventBloc, CreateEventState>(
              builder: (context, state) {
                if (state is EventTypesLoaded) {
                  List<EventTypeModel> list = state.list;
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
