// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourevent/features/my_events/blocs/my_events/my_events_bloc.dart';
import 'package:yourevent/core/core.dart';
import 'package:yourevent/features/my_events/widgets/widgets.dart';

class CreatedEventsPage extends StatefulWidget {
  final String text;
  const CreatedEventsPage({required this.text, super.key});

  @override
  State<CreatedEventsPage> createState() => _CreatedEventsPageState();
}

class _CreatedEventsPageState extends State<CreatedEventsPage> {
  @override
  void initState() {
    context.read<MyEventsBloc>().add(const MyEventsLoad(completer: null));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //final theme = Theme.of(context);
    return BlocBuilder<MyEventsBloc, MyEventsState>(
      builder: (context, state) {
        if (state is MyEventsError) {
          final error = state.error;
          return Center(child: Text(error.toString()));
        }
        if (state is MyEventsLoaded) {
          return ListView.builder(
              itemCount: state.list.length,
              itemBuilder: (context, index) {
                final event = state.list[index];

                return EventListCard(
                  event: event,
                );
              });
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
