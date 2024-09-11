import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
            length: 3,
            vsync: Scaffold.of(context),
            initialIndex: tabIndex,
          );
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                title: const Text("Мои события"),
                centerTitle: true,
                bottom: TabBar(
                  onTap: (index) {
                    context.read<TabBarBloc>().add(TabChanged(index: index));
                  },
                  tabs: const [
                    Tab(text: 'Tab 1'),
                    Tab(text: 'Tab 2'),
                    Tab(text: 'Tab 3'),
                  ],
                  controller: tabController,
                ),
              ),
              SliverFillRemaining(
                  child: TabBarView(
                controller: tabController,
                children: const [
                  TabContent(
                    text: '1',
                  ),
                  TabContent(
                    text: '2',
                  ),
                  TabContent(
                    text: '3',
                  )
                ],
              ))
            ],
          );
        },
      ),
    );
  }
}

class TabContent extends StatelessWidget {
  final String text;
  const TabContent({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: const TextStyle(fontSize: 24),
      ),
    );
  }
}
