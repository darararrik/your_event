import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourevent/core/data/repositories/models/agency_service/agency_service_dto.dart';
import 'package:yourevent/features/event_screens/event/presentation/bloc/event/event_bloc.dart';

@RoutePage()
class ServiceDetailsScreen extends StatelessWidget {
  final AgencyServiceDto service;

  const ServiceDetailsScreen({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(service.serviceName)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Цена: ${service.price} руб.",
                style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.read<EventBloc>().add(AddServiceEvent(service));
                Navigator.of(context).pop(); // Закрыть экран
              },
              child: const Text("Добавить в событие"),
            ),
          ],
        ),
      ),
    );
  }
}
