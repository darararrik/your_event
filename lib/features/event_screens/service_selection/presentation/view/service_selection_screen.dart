import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourevent/core/blocs/event_type/event_type_bloc.dart';
import 'package:yourevent/features/event_screens/event/presentation/bloc/event/event_bloc.dart';
import 'package:yourevent/features/event_screens/service_details/Presentation/view/service_details_screen.dart';
import 'package:yourevent/features/event_screens/service_selection/presentation/service/service_bloc.dart';

@RoutePage()
class ServiceSelectionScreen extends StatefulWidget {
  const ServiceSelectionScreen({super.key});

  @override
  State<ServiceSelectionScreen> createState() => _ServiceSelectionScreenState();
}

class _ServiceSelectionScreenState extends State<ServiceSelectionScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ServiceBloc>().add(LoadServices());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Выбор услуг")),
      body: BlocBuilder<ServiceBloc, ServiceState>(
        builder: (context, state) {
          if (state is ServicesLoaded) {
            return ListView.builder(
              itemCount: state.services.length,
              itemBuilder: (context, index) {
                final service = state.services[index];
                return Card(
                  child: ListTile(
                    title: Text(service.serviceName),
                    subtitle: Text("Цеdна: ${service.price} руб."),
                    trailing: IconButton(
                      icon: const Icon(Icons.add_shopping_cart),
                      onPressed: () {
                        context.read<EventBloc>().add(AddServiceEvent(service));
                        Navigator.of(context)
                            .pop(); // Вернуться на экран события
                      },
                    ),
                  ),
                );
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
