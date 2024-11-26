import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourevent/core/utils/utils.dart';
import 'package:yourevent/core/widgets/agent_card.dart';
import 'package:yourevent/core/widgets/button_widget.dart';
import 'package:yourevent/features/event_screens/event/presentation/bloc/event/event_bloc.dart';
import 'package:yourevent/features/event_screens/service_selection/presentation/service/service_bloc.dart';
import 'package:yourevent/features/home/Presentation/widgets/create_event_button.dart';
import 'package:yourevent/features/home/Presentation/widgets/sort_filter_icon_widget.dart';
import 'package:yourevent/features/home/Presentation/widgets/widgets.dart';
import 'package:yourevent/router/router.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ServiceBloc>().add(LoadServices());
    final theme = Theme.of(context);
    return CustomScrollView(
      slivers: [
        _appBar(context),
        //Тень
        SliverPersistentHeader(
          pinned: true,
          delegate: _ShadowHeaderDelegate(),
        ),
        BlocBuilder<ServiceBloc, ServiceState>(
          builder: (context, state) {
            if (state is ServicesLoaded) {
              final count = state.services.length;
              return _filter(context, count, theme);
            }
            return _filter(context, 0, theme);
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
                        dto: list[index],
                      );
                    },
                    childCount: list.length, // Количество карточек
                  ),
                ),
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
      pinned: true,
    );
  }
}

SliverToBoxAdapter _filter(BuildContext context, int count, theme) {
  return SliverToBoxAdapter(
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
                    "Найдено $count объявлений",
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
    ]),
  );
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
