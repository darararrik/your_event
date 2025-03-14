import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourevent/core/utils/utils.dart';
import 'package:yourevent/core/widgets/agent_card.dart';
import 'package:yourevent/core/widgets/button_widget.dart';
import 'package:yourevent/core/widgets/filter_widget.dart';
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
              final number = state.services.length;
              return SliverToBoxAdapter(child: FilterWidget(number: number));
            }
            return SliverToBoxAdapter(child: FilterWidget(number: 0));
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
                        service: list[index],
                      );
                    },
                    childCount: list.length, // Количество карточек
                  ),
                ),
              );
            }
            if (state is ServicesLoading) {
              return SliverToBoxAdapter(
                child: CircularProgressIndicator(),
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
      surfaceTintColor: white,
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

void showSortOptions(BuildContext context) {
  final theme = Theme.of(context);
  showModalBottomSheet(
    context: context,
    isScrollControlled: true, // Позволяет изменять высоту bottom sheet
    builder: (BuildContext context) {
      return BlocBuilder<ServiceBloc, ServiceState>(
        builder: (context, state) {
          String selectedMethod =
              "По умолчанию"; // Переменная для хранения выбранного метода
          if (state is ServicesLoaded) {
            selectedMethod =
                state.sortingMethod; // Получаем текущий метод сортировки
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0)
                .copyWith(bottom: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize
                  .min, // Ограничиваем высоту до необходимого размера
              children: [
                // Полоска сверху
                Container(
                  height: 4, // Высота полоски
                  width: 32, // Ширина полоски
                  margin: const EdgeInsets.symmetric(
                      vertical: 16), // Отступы вокруг полоски
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.grey, // Цвет полоски
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        "Сортировать",
                        style: theme.textTheme.titleLarge,
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        context.read<ServiceBloc>().add(LoadServices());
                        Navigator.pop(context);
                      },
                      title: Row(
                        children: [
                          Radio<String>(
                            fillColor: WidgetStatePropertyAll(orange),
                            activeColor: orange,
                            value: "По умолчанию",
                            groupValue: selectedMethod,
                            onChanged: (value) {},
                          ),
                          Text("По умолчанию",
                              style: theme.textTheme.titleMedium),
                        ],
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        context
                            .read<ServiceBloc>()
                            .add(SortServicesAscending());
                        Navigator.pop(context);
                      },
                      title: Row(
                        children: [
                          Radio<String>(
                            fillColor: WidgetStatePropertyAll(orange),
                            activeColor: orange,
                            value: "По цене (сначала дешевле)",
                            groupValue: selectedMethod,
                            onChanged: (value) {},
                          ),
                          Text("По цене (сначала дешевле)",
                              style: theme.textTheme.titleMedium),
                        ],
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        context
                            .read<ServiceBloc>()
                            .add(SortServicesDescending());
                        Navigator.pop(context);
                      },
                      title: Row(
                        children: [
                          Radio<String>(
                            fillColor: WidgetStatePropertyAll(orange),
                            activeColor: orange,
                            value: "По цене (сначала дороже)",
                            groupValue: selectedMethod,
                            onChanged: (value) {},
                          ),
                          Text("По цене (сначала дороже)",
                              style: theme.textTheme.titleMedium),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
    },
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
