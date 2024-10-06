part of 'page_view_bloc.dart';

sealed class PageViewState extends Equatable {
  const PageViewState();
  
  @override
  List<Object> get props => [];
}

final class PageViewInitial extends PageViewState {}


class PageViewUpdated extends PageViewState {
  final int pageIndex;
  
  const PageViewUpdated({required this.pageIndex});
  
  @override
  List<Object> get props => [pageIndex];
}
