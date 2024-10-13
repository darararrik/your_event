import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourevent/core/utils/utils.dart';
import 'package:yourevent/features/my_events/presentation/blocs/my_events/my_events_bloc.dart';
import 'package:yourevent/features/my_events/presentation/widgets/widgets.dart';

class CreatedEventsPage extends StatefulWidget {
  final bool isCompleted;

  const CreatedEventsPage({
    super.key,
    required this.isCompleted,
  });

  @override
  State<CreatedEventsPage> createState() => _CreatedEventsPageState();
}

class _CreatedEventsPageState extends State<CreatedEventsPage> {
  @override
  void initState() {
    super.initState();
    context.read<MyEventsBloc>().add(const MyEventsLoad(completer: null));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyEventsBloc, MyEventsState>(
      builder: (context, state) {
        if (state is MyEventsError) {
          return Center(child: Text(state.error.toString()));
        }
        if (state is MyEventsLoaded) {
          // Фильтруем события в зависимости от isCompleted
          final filteredEvents = state.list
              .where((event) => event.isCompleted == widget.isCompleted)
              .toList();

          return ListView.builder(
            itemCount: filteredEvents.length,
            itemBuilder: (context, index) {
              final event = filteredEvents[index];
              return EventListCard(event: event);
            },
          );
        } else if (state is MyEventsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16).copyWith(top: 160),
            child: Column(
              children: <Widget>[
                folder,
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "У вас пока нет событий",
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "Создайте мероприятие самостоятельно либо свяжитесь с агентством",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: grey, fontSize: 14, height: 1.8, fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }
      },
    );
  }
}