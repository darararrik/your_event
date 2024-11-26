import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourevent/features/event_screens/my_events/presentation/blocs/blocs.dart';
import 'package:yourevent/features/event_screens/my_events/presentation/view/tabs/tabs.dart';

@RoutePage()
class MyEventsScreen extends StatelessWidget {
  const MyEventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TabBarEventBloc(),
      child: BlocBuilder<TabBarEventBloc, TabBarEventState>(
        builder: (context, state) {
          final tabIndex = (state is TabBarEventUpdated) ? state.tabIndex : 0;
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
                _AppBar(tabController: tabController),
                _Body(tabController: tabController)
              ],
            ),
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
          context.read<TabBarEventBloc>().add(TabChanged(index: index));
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
                  'Активные',
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
                  'Архив',
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
        hasScrollBody: true,
        child: TabBarView(
          controller: tabController,
          children: const [
            CreatedEventsPage(
              statuses: ["PLANNED"],
            ),
            CreatedEventsPage(statuses: ["CLOSED", "COMPLETED"]),
          ],
        ));
  }
}
