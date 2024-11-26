import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:yourevent/core/data/repositories/models/agency_service/agency_service_dto.dart';
import 'package:yourevent/core/widgets/agent_card_widget.dart';
import 'package:yourevent/features/event_screens/event/presentation/bloc/event/event_bloc.dart';
import 'package:yourevent/features/home/Presentation/widgets/sort_filter_icon_widget.dart';
import 'package:yourevent/lib.dart';

@RoutePage()
class ServiceDetailsScreen extends StatelessWidget {

  final AgencyServiceDto service;
  final lorem =
      "Lorem ipsum dolor sit amet consectetur. In mattis adipiscing fames ac pharetra. Ac hac senectus sem natoque. Magna nisl ornare aliquam sapien maecenas parturient augue. Massa malesuada duis accumsan mauris pharetra in.";
  const ServiceDetailsScreen(
      {super.key, required this.service,});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var currencyFormatter = NumberFormat.currency(locale: "ru_RU", symbol: "₽");

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(
              "Об услуге",
              style: theme.textTheme.headlineSmall,
            ),
            centerTitle: true,
          ),
          SliverFillRemaining(
            child: Column(
              children: [
                Padding(
                    padding: EdgeInsets.only(top: 12),
                    child: SizedBox(height: 275, child: placeholder)),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: grey,
                                  radius: 34,
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AgentCardWidget(service: service),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      //TODO: добавить в сущность город
                                      "Омск",
                                      style: theme.textTheme.bodySmall,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            favoriteIcon,
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          service.serviceName,
                          style: theme.textTheme.titleLarge,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          currencyFormatter.format(service.price),
                          style: theme.textTheme.headlineSmall,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Описание",
                          style: theme.textTheme.titleMedium!
                              .copyWith(color: grey),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          lorem,
                          style: theme.textTheme.titleMedium,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ButtonWidget(
                                width: 304,
                                height: 52,
                                text: "Оставить заявку",
                                onPressed: () {
                                  context
                                      .read<EventBloc>()
                                      .add(AddServiceEvent(service));
                                }),
                            SortFilterIconWidget(
                                icon: chat,
                                onTap: () {
                                  //context.router.navigate(EventRoute(eventData: eventData))
                                }),
                          ],
                        )
                      ]),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
