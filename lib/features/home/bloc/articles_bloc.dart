import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yourevent/features/home/models/article_model.dart';
import 'package:yourevent/features/home/repository/articles_repository.dart';

part 'articles_event.dart';
part 'articles_state.dart';

class ArticlesBloc extends Bloc<ArticlesEvent, ArticlesState> {
  final ArticlesRepository _articlesRepository;

  ArticlesBloc(this._articlesRepository) : super(ArticlesInitial()) {
    on<LoadArticles>(_onLoadArticles);
  }
Future<void> _onLoadArticles(
    LoadArticles event,
    Emitter<ArticlesState> emit,
  ) async {
    emit(ArticlesLoading());
    try {
      final articles = await _articlesRepository.fetchArticles();
      emit(ArticlesLoaded( articles: articles,));
    } catch (e) {
      emit(ArticlesError('Failed to load articles: $e'));
    }
  }
}

