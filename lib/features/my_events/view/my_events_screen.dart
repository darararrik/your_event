import 'dart:async';

import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourevent/core/Presentation/blocs/my_events/my_events_bloc.dart';
import 'package:yourevent/core/core.dart';
import 'package:yourevent/core/Presentation/blocs/create_event/create_event_bloc.dart';
import 'package:yourevent/features/my_events/bloc/tab_bar_bloc.dart';

@RoutePage()
class MyEventsScreen extends StatelessWidget {
  const MyEventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TabBarBloc(),
      child: BlocBuilder<TabBarBloc, TabBarState>(
        builder: (context, state) {
          final tabIndex = (state is TabBarUpdated) ? state.tabIndex : 0;
          final tabController = TabController(
            length: 2,
            vsync: Scaffold.of(context),
            initialIndex: tabIndex,
          );
          return RefreshIndicator(
            onRefresh: () async {
              final completer = Completer();
              context
                  .read<MyEventsBloc>()
                  .add(MyEventsLoad(completer: completer));
              return completer.future;
            },
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  title: const Text("Мои события"),
                  centerTitle: true,
                  bottom: TabBar(
                    onTap: (index) {
                      context.read<TabBarBloc>().add(TabChanged(index: index));
                    },
                    tabs: [
                      Tab(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.add_circle_outline_outlined),
                            const SizedBox(
                              width: 8,
                            ),
                            //TODO: верстка
                            Text('Созданные',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall!
                                    .copyWith(color: orange)),
                          ],
                        ),
                      ),
                      Tab(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.abc),
                            const SizedBox(
                              width: 8,
                            ),
                            //TODO: верстка

                            Text('Выполненные',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall!
                                    .copyWith(color: orange)),
                          ],
                        ),
                      ),
                    ],
                    controller: tabController,
                  ),
                ),
                SliverFillRemaining(
                    child: TabBarView(
                  controller: tabController,
                  children: const [
                    CreatedEventsPage(
                      text: '1',
                    ),
                    CreatedEventsPage(
                      text: '2',
                    ),
                  ],
                ))
              ],
            ),
          );
        },
      ),
    );
  }
}

class CreatedEventsPage extends StatelessWidget {
  final String text;
  const CreatedEventsPage({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MyEventsBloc, MyEventsState>(
      listener: (BuildContext context, MyEventsState state) {},
      builder: (context, state) {
        if (state is MyEventsError) {
          final error = state.error;
          return Center(child: Text(error.toString()));
        }

        if (state is MyEventsLoaded) {
          return Center(
            child: Text(
              text,
              style: const TextStyle(fontSize: 24),
            ),
          );
        } else {
          return const Center();
        }
      },
    );
  }
}
