import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:yourevent/core/core.dart';
import 'package:yourevent/core/data/repositories/models/agency_service/agency_service_dto.dart';
import 'package:yourevent/core/widgets/agent_card.dart';
import 'package:yourevent/features/event_screens/event/presentation/bloc/event/event_bloc.dart';
import 'package:yourevent/features/event_screens/event/presentation/widgets/about_event_card.dart';
import 'package:yourevent/features/event_screens/event/presentation/widgets/agency_service_card.dart';
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
        _appBar(context),
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
                          "Подключенные услуги",
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
                          final groupedServices = state.groupedServices;

                          return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.only(top: 12),
                            shrinkWrap: true,
                            itemCount: groupedServices.keys.length,
                            itemBuilder: (context, index) {
                              final agencyName =
                                  groupedServices.keys.elementAt(index);
                              final services = groupedServices[agencyName]!;
                              return AgencyServiceCard(
                                agencyName: agencyName,
                                services: services,
                              );
                            },
                          );
                        }
                        return GestureDetector(
                          onTap: () {
                            context.router.push(const ServiceSelectionRoute());
                          },
                          child: Container(
                              margin: EdgeInsets.only(top: 20),
                              height: 154,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: outline_Grey, width: 2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    addEventIcon,
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      "Добавить услуги",
                                      style: theme.textTheme.bodyMedium!
                                          .copyWith(
                                              color: outline_Grey,
                                              fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              )),
                        );
                      }),
                      BlocBuilder<EventBloc, EventState>(
                        builder: (context, state) {
                          if (state is EventServiceAdded) {
                            double fold = (state.services
                                .fold(0.0, (sum, item) => sum + item.price));
                            return Column(
                              children: [
                                const Divider(
                                  height: 1,
                                  color: outline_Grey,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
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
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                ButtonWidget(
                                  text: 'Подобрать еще',
                                  onPressed: () {
                                    context.router
                                        .push(const ServiceSelectionRoute());
                                  },
                                )
                              ],
                            );
                          } else {
                            return const SizedBox();
                          }
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  SliverAppBar _appBar(BuildContext context) {
    final theme = Theme.of(context);
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
