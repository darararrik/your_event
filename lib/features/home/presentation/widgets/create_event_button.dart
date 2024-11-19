import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourevent/core/blocs/event_type/event_type_bloc.dart';
import 'package:yourevent/core/utils/colors.dart';
import 'package:yourevent/core/utils/images.dart';
import 'package:yourevent/router/router.dart';


class CreateEventButton extends StatelessWidget {
  const CreateEventButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        context.read<EventTypeBloc>().add(const LoadEvent());
        context.router.push(const EventTypeRoute());
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        width: double.infinity,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            gradient: LinearGradient(colors: <Color>[
              Color.fromRGBO(232, 133, 52, 1),
              Color.fromRGBO(255, 71, 175, 1)
            ])),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            surprise,
            const SizedBox(width: 8),
            Text("Создать событие",
                style: theme.textTheme.titleLarge!.copyWith(color: white)),
          ],
        ),
      ),
    );
  }
}
