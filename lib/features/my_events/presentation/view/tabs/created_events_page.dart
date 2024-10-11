import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    // Загружаем события один раз при инициализации
    context.read<MyEventsBloc>().add(const MyEventsLoad(completer: null));
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        final completer = Completer();
        context.read<MyEventsBloc>().add(MyEventsLoad(completer: completer));
        return completer.future;
      },
      child: BlocBuilder<MyEventsBloc, MyEventsState>(
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
            return const Center(child: Text("Событий нет"));
          }
        },
      ),
    );
  }
}
