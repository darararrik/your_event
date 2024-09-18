import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourevent/features/create_event/view/create_event_screen.dart';
import 'package:yourevent/features/home/bloc/articles_bloc.dart';
import 'package:yourevent/features/home/repository/articles_repository.dart';
import 'package:yourevent/features/home/widgets/icon_button_widget.dart';
import 'package:yourevent/features/home/widgets/row_icon.dart';
import '../../../core/design/design.dart';
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
                        style: theme.textTheme.headlineLarge!.copyWith(height: 1),
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
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => const CreateEventScreen())
                          );
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
                          itemCount: state.articles.length,
                          itemBuilder: (context, index) {
                            final article = state.articles[index];
                            return ListTile(
                              title: Text(article.title),
                              subtitle: Text(article.content),
                              onTap: () {
                                // TODO: Реализовать переход на страницу статьи
                              },
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
