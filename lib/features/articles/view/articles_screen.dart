import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:yourevent/core/utils/colors.dart';
import 'package:yourevent/features/home/data/models/article_model.dart';
import 'package:yourevent/features/home/presentation/bloc/articles_bloc.dart';
import 'package:yourevent/features/home/presentation/widgets/widgets.dart';

@RoutePage()
class ArticlesScreen extends StatelessWidget {
  const ArticlesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverAppBar(
          title: Text(
            "Все статьи",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          centerTitle: true,
        ),
        SliverFillRemaining(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: BlocBuilder<ArticlesBloc, ArticlesState>(
              builder: (context, state) {
                if (state is ArticlesLoaded) {
                  return ListView.builder(
                    itemCount: state.articles.length,
                    itemBuilder: (context, index) {
                      final article = state.articles[index];

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 24),
                        child: CardWidget(
                            onTap: () {
                              _showContentArticle(context, article, theme);
                            },
                            article: article,
                            width: double.infinity,
                            height: 220),
                      );
                    },
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ),
        ),
      ]),
    );
  }

  Future<void> _showContentArticle(
      BuildContext context, ArticleModel article, ThemeData theme) {
    return showModalBottomSheet<void>(
      elevation: 0,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 70),
        child: Container(
            height: double.infinity,
            decoration: const BoxDecoration(
                color: white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
            child: Stack(
              children: [
                ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(24)),
                    child: Image.network(article.photoURL)),
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 90, bottom: 20),
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          color: white,
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(24))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16)
                            .copyWith(top: 40),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              DateFormat('d MMMM y', 'ru').format(article.time),
                              style: theme.textTheme.titleSmall,
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Text(
                              article.title,
                              style: theme.textTheme.headlineSmall,
                            ),
                            const SizedBox(
                              height: 18,
                            ),
                            Text(
                              article.content,
                              style: theme.textTheme.bodyMedium,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
