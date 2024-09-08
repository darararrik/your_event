import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourevent/core/blocs/auth/auth.dart';
import 'package:yourevent/features/home/widgets/icon_button_widget.dart';
import 'package:yourevent/features/home/widgets/row_icon.dart';
import 'package:yourevent/router/router.dart';

import '../../../core/design/design.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Unauthenticated) {
            context.router.replace(const StartRoute());
          }
        },
        builder: (context, state) {
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                automaticallyImplyLeading: false,
                toolbarHeight: 108,
                title: logo,
                centerTitle: true,
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: IconButton(
                      icon: Icon(
                        Icons.notifications_outlined,
                        size: 32,
                        color: theme.primaryColor,
                      ),
                      onPressed: () {},
                    ),
                  )
                ],
              ),
              SliverFillRemaining(
                  child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Хотите организовать мероприятие?",
                            style: theme.textTheme.headlineLarge!
                                .copyWith(height: 1),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Text(
                            "Выберите способ организации",
                            style: theme.textTheme.bodyLarge!
                                .copyWith(color: grey),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: IconButtonWidget(
                            text: 'Выбрать агентство мероприятий',
                            image: faqSearch,
                            onPressed: () {},
                          ),
                        ),
                        const SizedBox(
                          width: 60,
                        ),
                        Expanded(
                          child: IconButtonWidget(
                            text: 'Организую сам',
                            image: package,
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: RowIcon(
                        onTap: () {},
                        title: "Наши статьи",
                        icon: const Icon(Icons.arrow_right_rounded),
                      ),
                    ),
                    ArticleListView(),
                  ],
                ),
              ))
            ],
          );
        },
      ),
    );
  }
}

class ArticleListView extends StatelessWidget {
  // Заглушка для данных
  final List<Map<String, String>> articles = List.generate(
    5,
    (index) => {
      'title': 'Омские рестораны поборются за звание лучших в стране',
      'date': '2 мая 2024',
      'photoUrl': 'assets/images/pic.png', // Путь к изображению в assets
    },
  );

  ArticleListView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 228, // Высота ListView
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: articles.length,
        itemBuilder: (context, index) {
          final article = articles[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                //TODO: Сделать переход на экран статьи
              },
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Stack(
                  children: [
                    // Фотография, полностью покрывающая контейнер
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        article['photoUrl']!,
                        width: 260,
                        height:
                            240, // Устанавливаем высоту, чтобы изображение покрывало всю карточку
                        fit: BoxFit.cover,
                      ),
                    ),
                    // Текст поверх фотографии
                    Container(
                      width: 260,
                      height: 240,
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.symmetric(
                            horizontal: 12, vertical: 24),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              article['date']!,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 16),
                            ),
                            Text(
                              article['title']!,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(color: Colors.white, fontSize: 16),
                              overflow: TextOverflow.fade,
                            ),
                            const SizedBox(height: 2),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
