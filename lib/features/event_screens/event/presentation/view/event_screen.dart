import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:yourevent/core/core.dart';
import 'package:yourevent/core/data/repositories/models/agency_service/agency_service_dto.dart';
import 'package:yourevent/core/widgets/agent_card.dart';
import 'package:yourevent/features/event_screens/event/presentation/bloc/event/event_bloc.dart';
import 'package:yourevent/features/event_screens/event/presentation/widgets/about_event_card.dart';
import 'package:yourevent/router/router.dart';

@RoutePage()
class EventScreen extends StatelessWidget {
  final EventDto eventData;
  const EventScreen({super.key, required this.eventData});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CustomScrollView(
      slivers: [
        _appBar(theme, context),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              children: [
                AboutEventCard(eventData: eventData),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0, 4),
                          color: Colors.grey.withOpacity(0.1),
                          blurRadius: 33,
                          spreadRadius: 10,
                        )
                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          "Услуги",
                          style: theme.textTheme.titleLarge,
                        ),
                      ),
                      const Divider(
                        height: 1,
                        color: outline_Grey,
                      ),
                      BlocBuilder<EventBloc, EventState>(
                          builder: (context, state) {
                        if (state is EventServiceAdded) {
                          final list2 = state.services;
                          return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: list2.length,
                            itemBuilder: (context, index) {
                              return AgentCard(
                                dto: list2[index],
                              );
                            },
                          );
                        }
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 24.0),
                          child: Center(child: Text("Услуги пока не выбраны")),
                        );
                      }),
                      const SizedBox(
                        height: 20,
                      ),
                      const Divider(
                        height: 1,
                        color: outline_Grey,
                      ),
                      BlocBuilder<EventBloc, EventState>(
                        builder: (context, state) {
                          if (state is EventServiceAdded) {
                            double fold = (state.services
                                .fold(0.0, (sum, item) => sum + item.price));
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Итого:",
                                    style: theme.textTheme.titleLarge,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        fold.toString(),
                                        style: theme.textTheme.titleLarge,
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        "руб",
                                        style: theme.textTheme.titleLarge,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return const Text("");
                          }
                        },
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      ButtonWidget(
                          text: "Подобрать еще",
                          onPressed: () {
                            context.router.push(const ServiceSelectionRoute());
                          })
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  SliverAppBar _appBar(ThemeData theme, BuildContext context) {
    return SliverAppBar(
      title: Text(
        "О событии",
        style: theme.textTheme.headlineSmall,
      ),
      leading: BackButton(
          onPressed: () => context.router.popAndPush(const MyEventsRoute())),
      centerTitle: true,
      actions: [IconButton(onPressed: () {}, icon: editIcon)],
    );
  }
}
