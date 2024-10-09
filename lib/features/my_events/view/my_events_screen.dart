// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourevent/features/my_events/blocs/my_events/my_events_bloc.dart';
import 'package:yourevent/core/core.dart';
import 'package:yourevent/features/create_event/Presentation/bloc/create_event/create_event_bloc.dart';
import 'package:yourevent/features/my_events/blocs/tab_bar_bloc/tab_bar_bloc.dart';
import 'package:yourevent/features/my_events/view/tabs/created_events_page.dart';

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
          return CustomScrollView(
            slivers: [
              _AppBar(tabController: tabController),
              _Body(tabController: tabController)
            ],
          );
        },
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar({
    required this.tabController,
  });

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SliverAppBar(
      title: Text(
        "Мои события",
        style: theme.textTheme.headlineSmall,
      ),
      centerTitle: true,
      bottom: TabBar(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        onTap: (index) {
          context.read<TabBarBloc>().add(TabChanged(index: index));
        },
        tabs: const [
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(CupertinoIcons.square_list),
                SizedBox(
                  width: 8,
                ),
                Text(
                  'Созданные',
                ),
              ],
            ),
          ),
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(CupertinoIcons.archivebox),
                SizedBox(
                  width: 8,
                ),
                Text(
                  'Выполненные',
                ),
              ],
            ),
          ),
        ],
        controller: tabController,
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    required this.tabController,
  });

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
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
    ));
  }
}
