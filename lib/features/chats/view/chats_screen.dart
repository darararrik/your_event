import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourevent/core/utils/images.dart';
import 'package:yourevent/core/utils/utils.dart';
import 'package:yourevent/features/chats/bloc/tab_bar_chat_bloc.dart';

@RoutePage()
class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //final theme = Theme.of(context);
    return BlocProvider(
      create: (context) => TabBarChatBloc(),
      child: BlocBuilder<TabBarChatBloc, TabBarChatState>(
        builder: (context, state) {
          final tabIndex = (state is TabBarChatUpdated) ? state.tabIndex : 0;
          final tabController = TabController(
            length: 2,
            vsync: Scaffold.of(context),
            initialIndex: tabIndex,
          );
          return CustomScrollView(
            slivers: [
              _AppBar(
                tabController: tabController,
              ),
              SliverFillRemaining(
                hasScrollBody: true,
                child: TabBarView(controller: tabController, children: [
                  Center(
                    child: CircularProgressIndicator(),
                  ),
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
                ]),
              )
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
        "Чаты",
        style: theme.textTheme.headlineSmall,
      ),
      centerTitle: true,
      bottom: TabBar(
        controller: tabController,
        tabs: const [
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Отклики',
                ),
              ],
            ),
          ),
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Сделки',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
