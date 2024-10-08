import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yourevent/features/create_event/Presentation/Presentation.dart';
import 'package:yourevent/features/home/bloc/bloc.dart';
import 'package:yourevent/features/home/widgets/widgets.dart';
import 'package:yourevent/router/router.dart';
import '../../../core/utils/ui.dart';

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
                        onPressed: () {},
                      ),
                    ),
                    const SizedBox(width: 60),
                    Expanded(
                      child: IconButtonWidget(
                        text: 'Организую сам',
                        image: package,
                        onPressed: () {
                          context
                              .read<CreateEventBloc>()
                              .add(const EventTypesLoad(completer: null));

                          context.router.push(const EventTypeRoute());
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: RowIcon(
                    onTapFunc: () {},
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
