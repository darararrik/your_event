import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourevent/core/utils/utils.dart';
import 'package:yourevent/features/create_event/presentation/presentation.dart';
import 'package:yourevent/features/home/presentation/bloc/articles_bloc.dart';
import 'package:yourevent/features/home/presentation/widgets/widgets.dart';
import 'package:yourevent/router/router.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CustomScrollView(
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
          hasScrollBody: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                // Добавляем статический контент
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
                  child: _title(theme),
                ),
                const SizedBox(height: 20),
                _buttons(context),
                const SizedBox(height: 32),
                _titleArticle(context, theme),
                const SizedBox(
                  height: 20,
                ),
                _artilcesCards(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  SizedBox _artilcesCards() {
    return SizedBox(
                height: 240,
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
              );
  }

  GestureDetector _titleArticle(BuildContext context, ThemeData theme) {
    return GestureDetector(
                onTap: () {
                  context.router.push(const ArticlesRoute());
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12)
                      .copyWith(right: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Наши статьи",
                        style: theme.textTheme.headlineMedium,
                      ),
                      const Chips(
                          icon: Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 14,
                          ),
                          title: "title")
                    ],
                  ),
                ),
              );
  }

  Row _buttons(BuildContext context) {
    return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    child: IconButtonWidget(
                      text: 'Выбрать агентство мероприятий',
                      image: faqSearch,
                      onTap: () {},
                    ),
                  ),
                  SizedBox(
                    child: IconButtonWidget(
                      text: 'Организую сам',
                      image: package,
                      onTap: () {
                        context
                            .read<CreateEventBloc>()
                            .add(const EventTypesLoad(completer: null));
                        context.router.push(const EventTypeRoute());
                      },
                    ),
                  ),
                ],
              );
  }

  Row _title(ThemeData theme) {
    return Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14.0, vertical: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: const LinearGradient(colors: <Color>[
                            Color.fromRGBO(234, 115, 18, 1),
                            Color.fromRGBO(255, 0, 0, 1)
                          ])),
                      child: Text(
                        "1",
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontStyle: FontStyle.italic,
                          fontSize: 18,
                          color: white,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Text(
                      "Выберите способ организации",
                      style: theme.textTheme.bodySmall!
                          .copyWith(color: grey, fontSize: 16, height: 1.6),
                    ),
                  ],
                );
  }
}
