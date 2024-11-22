import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourevent/core/utils/utils.dart';
import 'package:yourevent/core/widgets/agent_card.dart';
import 'package:yourevent/core/widgets/button_widget.dart';
import 'package:yourevent/features/home/Presentation/bloc/articles_bloc.dart';
import 'package:yourevent/features/home/Presentation/widgets/create_event_button.dart';
import 'package:yourevent/features/home/Presentation/widgets/sort_filter_icon_widget.dart';
import 'package:yourevent/features/home/Presentation/widgets/widgets.dart';
import 'package:yourevent/router/router.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CustomScrollView(
      slivers: [
        _appBar(context),
        //Тень
        SliverPersistentHeader(
          pinned: true,
          delegate: _ShadowHeaderDelegate(),
        ),
        SliverFillRemaining(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 8, 0, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Выберите услуги",
                          style: theme.textTheme.titleMedium,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          "Найдено 123 объявлений",
                          style: theme.textTheme.bodySmall,
                        )
                      ],
                    ),
                    Row(
                      children: [
                        SortFilterIconWidget(
                          icon: sortIcon,
                          onTap: () {},
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        SortFilterIconWidget(
                          icon: filterIcon,
                          onTap: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Expanded(
            //   child: ListView.builder(
            //     padding: const EdgeInsets.fromLTRB(0, 0, 0, 80),
            //     itemCount: 10,
            //     itemBuilder: (context, index) {
            //       return const AgentCard();
            //     },
            //   ),
            // ),
          ]),
        ),
      ],
    );
  }

  SliverAppBar _appBar(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.white,
      toolbarHeight: 172,
      flexibleSpace: Stack(
        children: [
          // Лого по центру
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: logo,
                  ),
                  const SizedBox(height: 20),
                  const CreateEventButton(),
                ],
              ),
            ),
          ),
          // Иконка уведомлений справа с отступом 16 пкс
          Positioned(
            right: 16,
            top: 40, // Настройте отступ сверху для выравнивания
            child: IconButton(
              icon: Icon(
                Icons.notifications_outlined,
                size: 32,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () {
                //TODO: Реализация
              },
            ),
          ),
        ],
      ),
      centerTitle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
    );
  }
}

class _ShadowHeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.13), // Настройте цвет тени
            offset: Offset(0, 4),
            spreadRadius: 8,
            blurRadius: 33,
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 1;

  @override
  double get minExtent => 1;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
