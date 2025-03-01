import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourevent/core/blocs/event_type/event_type_bloc.dart';
import 'package:yourevent/core/widgets/agent_card.dart';
import 'package:yourevent/core/widgets/filter_widget.dart';
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
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Поиск услуг",
            style: theme.textTheme.headlineSmall,
          )),
      body: CustomScrollView(slivers: [
        BlocBuilder<ServiceBloc, ServiceState>(
          builder: (context, state) {
            if (state is ServicesLoaded) {
              final number = state.services.length;
              return SliverToBoxAdapter(child: FilterWidget(number: number));
            }
            return SliverToBoxAdapter(child: FilterWidget(number: 0));
          },
        ),
        BlocBuilder<ServiceBloc, ServiceState>(
          builder: (context, state) {
            if (state is ServicesLoaded) {
              final list = state.services;
              return SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16)
                    .copyWith(bottom: 100),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Количество столбцов
                    crossAxisSpacing: 20, // Промежуток между столбцами
                    mainAxisSpacing: 20, // Промежуток между строками
                    childAspectRatio:
                        0.75, // Соотношение ширины и высоты карточки
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return AgentCard(
                        service: list[index],
                      );
                    },
                    childCount: list.length, // Количество карточек
                  ),
                ),
              );
            }
            if (state is ServicesLoading) {
              return SliverToBoxAdapter(
                child: CircularProgressIndicator(),
              );
            }
            return SliverToBoxAdapter(
              child: SizedBox(
                height:
                    MediaQuery.of(context).size.height * 0.5, // Задайте высоту
                child: Center(
                  child: Text(
                    "Услуги не найдены.",
                    style: theme.textTheme.headlineSmall,
                  ),
                ),
              ),
            );
          },
        ),
      ]),
    );
  }
}
