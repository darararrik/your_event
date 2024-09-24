import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourevent/features/create_event/view/event_confirm_screen.dart';
import 'package:yourevent/features/home/bloc/articles_bloc.dart';
import 'package:yourevent/features/home/models/article_model.dart';
import 'package:yourevent/features/home/repository/articles_repository.dart';
import 'package:yourevent/features/home/widgets/icon_button_widget.dart';
import 'package:yourevent/features/home/widgets/row_icon.dart';
import 'package:yourevent/router/router.dart';
import '../../../core/ui/design.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CustomScrollView(
      physics: const NeverScrollableScrollPhysics(),
      slivers: [
        SliverAppBar(
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
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              children: [
                // Добавляем статический контент
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Хотите организовать мероприятие?",
                        style:
                            theme.textTheme.headlineLarge!.copyWith(height: 1),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "Выберите способ организации",
                        style: theme.textTheme.bodyLarge!.copyWith(color: grey),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: IconButtonWidget(
                        text: 'Выбрать агентство мероприятий',
                        image: faqSearch,
                        onPressed: () {
                          
                          context.router.push(const EventTypeRoute());
                        },
                      ),
                    ),
                    const SizedBox(width: 60),
                    Expanded(
                      child: IconButtonWidget(
                        text: 'Организую сам',
                        image: package,
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: RowIcon(
                    onTap: () {},
                    title: "Наши статьи",
                    icon: const Icon(Icons.arrow_right_rounded),
                  ),
                ),

                // Добавляем BlocBuilder для отображения статей
                Expanded(
                  child: BlocBuilder<ArticlesBloc, ArticlesState>(
                    builder: (context, state) {
                      if (state is ArticlesLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is ArticlesLoaded) {
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.articles.length,
                          itemBuilder: (context, index) {
                            final article = state.articles[index];
                            return Padding(
                              padding: const EdgeInsets.only(right: 12),
                              child: CardWidget(
                                article: article,
                                width: 260,
                                height: 240,
                              ),
                            );
                          },
                        );
                      } else if (state is ArticlesError) {
                        return Center(child: Text(state.message));
                      }

                      return const Center(child: Text('No articles found.'));
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class CardWidget extends StatelessWidget {
  CardWidget({
    super.key,
    required this.article,
    required this.width,
    required this.height,
  });
  double width;
  double height;
  final ArticleModel article;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //TODO Сделать переход на статью
      },
      child: Stack(
        children: [
          // Фотография, полностью покрывающая контейнер
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              article.photoURL,
              width: width,
              height:
                  height, // Устанавливаем высоту, чтобы изображение покрывало всю карточку
              fit: BoxFit.cover,
            ),
          ),
          // Текст поверх фотографии
          Container(
            width: width, //260,
            height: height, //240,
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
                    article.time.toString(),
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        fontSize: 16),
                  ),
                  Text(
                    article.title,
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
    );
  }
}
